# Example: California VEHICLE CODE SECTION 22450-22456
# 22450.  (a) The driver of any vehicle approaching a stop sign at the
# entrance to, or within, an intersection shall stop at a limit line,
# if marked, otherwise before entering the crosswalk on the near side
# of the intersection.
#    If there is no limit line or crosswalk, the driver shall stop at
# the entrance to the intersecting roadway.
#    (b) The driver of a vehicle approaching a stop sign at a railroad
# grade crossing shall stop at a limit line, if marked, otherwise
# before crossing the first track or entrance to the railroad grade
# crossing.
#    (c) Notwithstanding any other provision of law, a local authority
# may adopt rules and regulations by ordinance or resolution providing
# for the placement of a stop sign at any location on a highway under
# its jurisdiction where the stop sign would enhance traffic safety.

law 'special stops required' do
  define(:crosswalk)
  define(:limit_line)
  define(:stop_sign)

  define(:intersection)
    .has(:entrance)
    .can_have(:crosswalk)
    .can_have(:limit_line)
    .can_have(:stop_sign)

  define(:speed)
  define(:vehicle)
    .has_property(:speed)
    .has_relation(:position)
    .can_have_relation(:approaching).to(:intersection)
  person(:driver).has(:vehicle)

  # define(:stop).as { |obj| speed.of(obj) == 0 }


  if intersection.has(stop_sign) and driver.has(vehicle) and vehicle.is.approaching(intersection)
    driver.shall { vehicle.speed == 0 }
    if intersection.has(:limit_line)
      driver.shall { vehicle.position.is(limit_line) }
    elsif intersection.has(:crosswalk)
      driver.shall { vehicle.position.is(crosswalk) }
    else
      driver.shall { vehicle.positionis.(intersection.entrance) }
    end
  end
end
