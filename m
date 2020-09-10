Content-Type: multipart/mixed; boundary="===============4264420048012312634=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "mptcp: add the incoming RM_ADDR
 support"
Date: Thu, 10 Sep 2020 21:03:17 +0200
Message-ID: <f0e8c845-68e2-3aed-53ae-b870dd93b1ea@tessares.net>
In-Reply-To: e2678d7012e25752b2826bd866b07b338fb18d3f.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5789

--===============4264420048012312634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Paolo,

On 10/09/2020 18:28, Paolo Abeni wrote:
> On Thu, 2020-09-03 at 18:38 +0800, Geliang Tang wrote:
>> This squash-to patch fixed three issues in "mptcp: add the incoming RM_A=
DDR
>> support":
>>
>> 1. We will use another function mptcp_pm_nl_rm_subflow_received to remov=
e a
>> local subflow, so the mptcp_pm_nl_rm_addr_received function only need to
>> deal with remote address removing. Thus we only need to check
>> subflow->remote_id in mptcp_pm_nl_rm_addr_received.
>>
>> 2. Update PM counters in the right place.
>>
>> 3. Drop the remot_id fixing code here, since another new patch will deal=
 with
>> subflow's remote_id and local_id fixing.

Small note: I removed this part from the patch because I previously =

applied this new patch you mentioned before in the list of commits.

>>
>> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> =

> LGTM, thanks!

Thank you for the patch and the review!

Just applied:

- bef779739129: "squashed" (with conflicts) in "mptcp: add the incoming =

RM_ADDR support"
- b826ff1c8ae3..377cd31c5d51: result

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4264420048012312634==--
