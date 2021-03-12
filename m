Content-Type: multipart/mixed; boundary="===============5594487761050332589=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix bit MPTCP_PUSH_PENDING tests
Date: Fri, 12 Mar 2021 09:25:11 +0100
Message-ID: <abde7928-23dd-cef3-647e-99f6d85d9a60@tessares.net>
In-Reply-To: YEsbGCmx4Jh3fApi@mwanda
X-Status: 
X-Keywords:                  
X-UID: 8109

--===============5594487761050332589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

(MPTCP ML only)

On 12/03/2021 08:41, Dan Carpenter wrote:
> The MPTCP_PUSH_PENDING define is 6 and these tests should be testing if
> BIT(6) is set.
> =

> Fixes: c2e6048fa1cf ("mptcp: fix race in release_cb")
> Signed-off-by: Dan Carpenter <dan.carpenter(a)oracle.com>

This patch is now in our tree:

- fe202ab685d5: mptcp: fix bit MPTCP_PUSH_PENDING tests
- 09d2582abdb4: conflict in t/mptcp-clean-up-the-rtx-path
- Results: c1ab0a28e2b1..932a56a08a15

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5594487761050332589==--
