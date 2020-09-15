Content-Type: multipart/mixed; boundary="===============7955141205275362257=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "mptcp: add the incoming RM_ADDR
 support"
Date: Tue, 15 Sep 2020 10:34:46 +0200
Message-ID: <94573ece-bc1c-c22a-89ef-b277c49d21cb@tessares.net>
In-Reply-To: CA+WQbwu0geTUddKtZNiKyKwYSrxPFNFu5cbHq6787v3Bzkqvuw@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5873

--===============7955141205275362257==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 15/09/2020 10:04, Geliang Tang wrote:
> Hi Matt,
> =

> Thanks for applying this patch.
> =

> Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B49=
=E6=9C=8811=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=883:03=E5=86=99=E9=
=81=93=EF=BC=9A
>>
>> Hi Geliang, Paolo,
>>
>> On 10/09/2020 18:28, Paolo Abeni wrote:
>>> On Thu, 2020-09-03 at 18:38 +0800, Geliang Tang wrote:
>>>> This squash-to patch fixed three issues in "mptcp: add the incoming RM=
_ADDR
>>>> support":
>>>>
>>>> 1. We will use another function mptcp_pm_nl_rm_subflow_received to rem=
ove a
>>>> local subflow, so the mptcp_pm_nl_rm_addr_received function only need =
to
>>>> deal with remote address removing. Thus we only need to check
>>>> subflow->remote_id in mptcp_pm_nl_rm_addr_received.
>>>>
>>>> 2. Update PM counters in the right place.
>>>>
>>>> 3. Drop the remot_id fixing code here, since another new patch will de=
al with
>>>> subflow's remote_id and local_id fixing.
>>
>> Small note: I removed this part from the patch because I previously
>> applied this new patch you mentioned before in the list of commits.
> =

> That's fine, but there are duplicate code here. subflow->remote_id
> will be set twice:
> =

> 1078         subflow->remote_id =3D remote->id;
>   ... ...
> 1096         subflow->remote_id =3D remote_id;
> =

> I think we need to remove this duplicate code someday.

Oh yes OK, I didn't see the lines were different. I think I had =

conflicts for some other reasons and I thought the lines were the same.

Now fixed:

- 8d1ec4c8327c: mptcp: drop useless assignment

Tests + export will be started soon.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7955141205275362257==--
