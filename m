Content-Type: multipart/mixed; boundary="===============8117222757964962646=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 0/3] mptcp: netlink event fixes
Date: Wed, 03 Feb 2021 20:19:16 +0100
Message-ID: <d9fb6fea-53da-eb48-e5b7-31e87619e8bf@tessares.net>
In-Reply-To: 20210202174754.6861-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7614

--===============8117222757964962646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat,

On 02/02/2021 18:47, Florian Westphal wrote:
> While testing upcoming mptcp reset option support i found a few
> issues with netlink events.

Thank you for the patches and the reviews!

As discussed on IRC, I squashed patch 2/3 in "mptcp: add netlink event =

support":

- 51e4bae2c6c9: "squashed" patch 2/3 in "mptcp: add netlink event support"
- Results: f3a1a5d5ef41..eee71bc20e17

Then I added patches 1/3 and 3/3/ in our tree between "mptcp: split =

__mptcp_close_ssk helper" and "mptcp: pass subflow socket to a few =

helpers". I also added Mat's RvB tags:

- 95fc52697bf7: mptcp: schedule worker when subflow is closed
- 74975e28f8ec: mptcp: move subflow close loop after sk close check
- Results: eee71bc20e17..7b3ea53ce791

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8117222757964962646==--
