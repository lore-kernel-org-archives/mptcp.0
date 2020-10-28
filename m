Content-Type: multipart/mixed; boundary="===============8088459429447421044=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next] Squash to "mptcp: send out
 dedicated ADD_ADDR packet"
Date: Wed, 28 Oct 2020 12:56:07 +0100
Message-ID: <905e4345-671e-3ac2-b5fd-9716b308a331@tessares.net>
In-Reply-To: 62f113f3c6280a654a89f14f78f64390db4d4da3.1603854745.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6457

--===============8088459429447421044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Paolo,

On 28/10/2020 04:20, Geliang Tang wrote:
> Since the function name of sending ack is changed in this patch,
> please update the following lines in the commit message:
> =

> From
> =

> """
> mptcp_pm_check_send_dedicated_add_addr_packet to sent out a new pure
> ACK packet.
> """
> =

> to
> =

> """
> mptcp_pm_nl_add_addr_send_ack to sent out a new pure ACK packet.
> """
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/102
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> v3:
>   - add a new function mptcp_pm_add_addr_send_ack to schedule pm_work.
>   - rename mptcp_pm_check_send_dedicated_add_addr_packet to
>     mptcp_pm_nl_add_addr_send_ack.
>   - In mptcp_pm_add_addr_received and mptcp_pm_add_timer, we call
>    mptcp_pm_add_addr_send_ack to schedule pm_work.
>   - In mptcp_pm_nl_add_addr_received and mptcp_pm_create_subflow_or_signa=
l_addr,
>    we call mptcp_pm_nl_add_addr_send_ack directly.
> =

>   v2:
>   - Add a new command PTCP_PM_ADD_ADDR_SEND_ACK.
>   - call mptcp_pm_nl_send_dedicated_add_addr_packet from pm_work.

Thank you for the patch and the reviews!

- 4b03a9d34ff3: "squashed" in "mptcp: send out dedicated ADD_ADDR packet"
- 901828ce7f3b: tg:msg: function has changed: update commit message
- Results: c0ab9f0df37e..a3482e2c0b82

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8088459429447421044==--
