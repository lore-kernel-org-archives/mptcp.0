Content-Type: multipart/mixed; boundary="===============5730975066802839874=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/4] mptcp sparse "fixes"
Date: Sat, 21 Sep 2019 13:19:08 +0200
Message-ID: <8055e426-0e17-c04c-d3ed-1c5eb9068599@tessares.net>
In-Reply-To: 6fdfba964c0e7455f3992ec2bfdcd3680c8e9665.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1901

--===============5730975066802839874==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Peter,

On 16/09/2019 22:43, Peter Krystad wrote:
> =

> Hi Florian -
> =

> This all looks good to me, thanks.
> =

> Peter.
> =

> On Tue, 2019-09-10 at 01:17 +0200, Florian Westphal wrote:
>> NB: these patches don't fix anything because nothing is broken.
>>
>> The "sparse" checker complains about various constructs, this fixes
>> some of those.  All of these can be squashed, I've
>> placed the name of the target commit in the change logs.
>>
>> There are more sparse warnings in the code base, I am intentionally
>> skipping those for now as its in code that is still "in flux".
>>
>> For example the icsk ulp data pointer now has an __rcu annotation upstre=
am
>> so sparse complains because we don't use rcu_dereference() or similar.
>>
>> In any case, I think those can be fixed once the code has stabilized mor=
e.
>> I am sending these now because they are in more "mature" areas and it
>> reduces the delta between my working tree and the "export" branch.

Thank you for the patches and the reviews!

- ca9e24a3fc4b: "squashed" the 1st one in "mptcp: Add ADD_ADDR handling"
- 8e734cf08528: conflict in
t/mptcp-Make-MPTCP-socket-block-wakeup-ignore-sk_receive_queue
- signed-off was already there
- 0341ab0068b3..9281f9e12829: result
- f89dfa25b401: "squashed" the 2nd one in "mptcp: Write MPTCP DSS
headers to outgoing data packets"
- b93110fbba4a: add signed-off
- 9281f9e12829..e27f63c56155: result
- 22387add4faa: "squashed" the 3rd one in "mptcp: Add key generation and
token tree"
- signed-off was already there
- e27f63c56155..f51ca08dd4f3: result
- e0ce97687b36: "squashed" in "mptcp: Implement path manager interface
commands"
- cbb100c6570d: signed-off
- f51ca08dd4f3..4c186ad4f312: result

Tests are running now but I guess everything should still be OK!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============5730975066802839874==--
