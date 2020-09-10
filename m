Content-Type: multipart/mixed; boundary="===============2407834877013611577=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net] mptcp: fix kmalloc flag in
 mptcp_pm_nl_get_local_id
Date: Thu, 10 Sep 2020 12:30:42 -0700
Message-ID: <20200910.123042.1871577422517113304.davem@davemloft.net>
In-Reply-To: edf5e512a6932d9169f77d9cd5c89aa198b20d31.1599620248.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5792

--===============2407834877013611577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>
Date: Wed,  9 Sep 2020 11:01:24 +0800

> mptcp_pm_nl_get_local_id may be called in interrupt context, so we need to
> use GFP_ATOMIC flag to allocate memory to avoid sleeping in atomic contex=
t.
 ...
> Fixes: 01cacb00b35cb ("mptcp: add netlink-based PM")
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

Applied.
--===============2407834877013611577==--
