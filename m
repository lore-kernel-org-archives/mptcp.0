Content-Type: multipart/mixed; boundary="===============2673651703850231794=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next 0/5] mptcp: netlink event support
Date: Wed, 27 Jan 2021 09:23:24 +0100
Message-ID: <50659257-6516-d7b8-215e-f16662515467@tessares.net>
In-Reply-To: 6f6e3829-5b4b-bace-7cc1-d783df761dd0@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7494

--===============2673651703850231794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat,

On 26/01/2021 21:28, Matthieu Baerts wrote:
> - f15cd5fd4c26: mptcp: add netlink event support

I did a small extra modification on top of this patch to keep the =

alignment with the rest. Nothing important but still, if you need to =

copy the content of include/uapi/linux/mptcp.h elsewhere (i.e. iproute2 =

and mptcpd), please make sure to use the latest version :)

- 1f2bcf78ff83: mptcp: use tab to align mptcp_pm_events
- (of course no co-dev-by tag added for that)
- Results: 331067123e0c..1d8e7211c639

Tests + export are in progress.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2673651703850231794==--
