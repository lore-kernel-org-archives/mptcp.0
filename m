Content-Type: multipart/mixed; boundary="===============7342105811959997207=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] squashto: mptcp: schedule worker when subflow is
 closed
Date: Wed, 10 Feb 2021 20:06:02 +0100
Message-ID: <407c58a5-5e57-7b08-4543-0d293ce8ccdb@tessares.net>
In-Reply-To: 20210210124708.11899-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7752

--===============7342105811959997207==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Paolo, Mat,

On 10/02/2021 13:47, Florian Westphal wrote:
> When remote side closes a subflow we should schedule the worker to
> dispose of the subflow in a timely manner.
> =

> Otherwise, SF_CLOSED event won't be generated until the mptcp
> socket itself is closing or local side is closing another subflow.
> =

> As noted by Paolo and Matthieu, a subflow that moves to TCP_CLOSE state
> might still have data in its rx queue.
> =

> Add a helper to only schedule the work queue once the subflow is empty.
> =

> For subflows that still have data, we can do same schedule check
> in subflow_check_data_avail().
> =

> In case we have multiple subflows closing at the same time,
> also make the work queue skip subflows that are TCP_CLOSE with
> pending data.

Thank you for the patch and reviews!

- 0629948c0ae6: "squashed" in "mptcp: schedule worker when subflow is =

closed"
- Results: 9c096197d99f..36c9c494faa9

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7342105811959997207==--
