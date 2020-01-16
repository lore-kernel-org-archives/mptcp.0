Content-Type: multipart/mixed; boundary="===============0089893430765248457=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] subflow: remove unneded memory barriers
Date: Thu, 16 Jan 2020 17:50:12 +0100
Message-ID: <0afb94c3-c851-9451-4d7c-fde86ec2d6dc@tessares.net>
In-Reply-To: alpine.OSX.2.21.2001141645470.26562@ndoyal-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3380

--===============0089893430765248457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat,

On 15/01/2020 02:34, Mat Martineau wrote:
> On Wed, 15 Jan 2020, Florian Westphal wrote:
> =

>> squashto: mptcp: Implement MPTCP receive path
>>
>> The bit set operation has no prior dependencies, so
>> smp_mb__before_atomic() is not needed.
>>
>> It has no followup depenency: the woken task will always see the
>> bit set, plus wakeup code (called via sk_data_ready) acquires a spinlock.

[...]

> I agree that these barriers are not needed.

Thank you for the patch and the review!

- 53f6baf4672c: "squashed" in "mptcp: Implement MPTCP receive path"
- 41b3253570a8..91800c0574b2: result

Tests + export will be launched soon!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0089893430765248457==--
