Content-Type: multipart/mixed; boundary="===============1396960027133409628=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 1/7] selftests: mptcp: make tc delays random
Date: Wed, 23 Oct 2019 17:37:04 -0700
Message-ID: <alpine.OSX.2.21.1910231659010.37761@rjszuste-mobl.amr.corp.intel.com>
In-Reply-To: 20191023235538.GR25052@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2304

--===============1396960027133409628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 24 Oct 2019, Florian Westphal wrote:

> Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
>>> +delay=3D$((RANDOM%1000))
>>> +reorder1=3D$((RANDOM%10))
>>> +reorder1=3D$((100 - reorder1))
>>> +reorder2=3D$((RANDOM%100))
>>> +
>>> +if [ $reorder1 -lt 100 ] && [ $reorder2 -gt 0 ]; then
>>> +  tc -net ns3 qdisc add dev ns3eth4 root netem delay ${delay}ms reorde=
r ${reorder1}% ${reorder2}%
>>> +  echo "INFO: Using loss of $loss, delay $delay ms, reorder: $reorder1=
, $reorder2 on ns3eth4"
>>> +elif [ $delay -gt 0 ]; then
>>> +  tc -net ns3 qdisc add dev ns3eth4 root netem delay ${delay}ms
>>> +  echo "INFO: Using loss of $loss, delay $delay ms on ns3eth4"
>>> +fi
>>
>> I think it's ok to merge this patch, but randomly configuring with/witho=
ut
>> reordering does seem like a significant difference in test cases (and ma=
ybe
>> the gso/tso/gro changes in patch 4 reach that threshold too).
>>
>> There are situations where execution time is less of a concern than
>> coverage. What do you think about randomizing the netem and ethtool sett=
ings
>> by default, but having a command line option to run a larger set of test
>> cases?
>
> Thats a good idea, I'll think about what kind of settings would be useful
> to have.
>
> We can also reduce test time by not testing the fallback case anymore exc=
ept
> for the loopback, i.e. ns1 <-> ns1 with tcp -> mptcp, mptcp -> tcp, and
> mptcp -> mptcp, but for everything else just do the mptcp <-> mptcp
> tests.
>
> What do you think?

That would be a good way to save time. I don't think the combinations =

other than ns1 <-> ns1 do anything meaningfully different when everything =

from SYNACK onward is regular TCP.

--
Mat Martineau
Intel
--===============1396960027133409628==--
