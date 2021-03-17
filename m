Content-Type: multipart/mixed; boundary="===============6896119960988348806=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next] Squash to "mptcp: remove id
 0 address"
Date: Wed, 17 Mar 2021 11:35:25 +0100
Message-ID: <381120d3-ce02-cfd2-84d9-21c57ec75070@tessares.net>
In-Reply-To: be80ad2d5230a0e414a263c871172a4c5b3eaf50.1615871767.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8187

--===============6896119960988348806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Mat,

On 16/03/2021 06:18, Geliang Tang wrote:
> Hold msk->pm.lock when invoking mptcp_pm_remove_addr.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

Thank you for the patch and the review!

Now in our tree:

- 03d95186eb42: "squashed" in "mptcp: remove id 0 address"
- Results: 19f890a6dd32..a4aed0922265

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6896119960988348806==--
