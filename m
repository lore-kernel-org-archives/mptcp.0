Content-Type: multipart/mixed; boundary="===============9159271853191719415=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH V3 -next] mptcp/pm_netlink.c : add check for
 nla_put_in/6_addr
Date: Thu, 23 Apr 2020 15:38:32 -0700
Message-ID: <20200423.153832.2215576235773303096.davem@davemloft.net>
In-Reply-To: 20200423020957.g5ovpymbbp4nykbr@debian.debian-2
X-Status: 
X-Keywords:                  
X-UID: 4237

--===============9159271853191719415==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Bo YU <tsu.yubo(a)gmail.com>
Date: Thu, 23 Apr 2020 10:10:03 +0800

> Normal there should be checked for nla_put_in6_addr like other
> usage in net.
> =

> Detected by CoverityScan, CID# 1461639
> =

> Fixes: 01cacb00b35c("mptcp: add netlink-based PM")
> Signed-off-by: Bo YU <tsu.yubo(a)gmail.com>
> ---
> V3: fix code style, thanks for Paolo
> =

> V2: Add check for nla_put_in_addr suggested by Paolo Abeni

Applied, thank you.
--===============9159271853191719415==--
