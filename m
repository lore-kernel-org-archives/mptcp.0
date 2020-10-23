Content-Type: multipart/mixed; boundary="===============3006221061884799562=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 0/3] add ADD_ADDR IPv6 support
Date: Fri, 23 Oct 2020 20:02:54 +0200
Message-ID: <30981261-116c-33aa-372d-44adfa98e993@tessares.net>
In-Reply-To: cover.1603264085.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6426

--===============3006221061884799562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Paolo,

On 21/10/2020 09:19, Geliang Tang wrote:
> v5:
>   - drop msleep() in v4
>   - drop MPTCP_ADD_ADDR_SEND_ACK in v4
>   - add WRITE_ONCE/READ_ONCE for msk->pm.add_addr_signal
>   - depend on "mptcp: keep unaccepted MPC subflow into join list"
> =

> v4:
>   - update the patches as Paolo suggested:
>   - change the 'add_addr_signal' type
>   - set MPTCP_ADD_ADDR_IPV6 in mptcp_pm_announce_addr
>   - add a new helper mptcp_send_dedicated_add_addr_packet to sent out a
> new pure ACK packet
>   - drop other MPTCP suboptions in mptcp_established_options_add_addr
> =

> v3:
>   - drop other MPTCP suboptions instead of OPTION_TS
> =

> v2:
>   - avoid adding new field to tcp_sock, add new field in mptcp_pm_data.
>   - drop OPTION_TS in mptcp_established_options_add_addr, not in
> tcp_established_options.
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/55

Thank you for the patches and reviews!

- 93f241dc7682: mptcp: change add_addr_signal type
- 4769ab732416: mptcp: send out dedicated ADD_ADDR packet
- 261b6b50e4e0: selftests: mptcp: add ADD_ADDR IPv6 test cases
- Results: a1e156132206..d13ebf3a735c

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3006221061884799562==--
