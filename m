Content-Type: multipart/mixed; boundary="===============3709478549251713468=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: drop CANCEL_WORK status bit
Date: Wed, 18 Nov 2020 18:32:13 +0100
Message-ID: <3918b547-1bbf-f7c8-4a6d-48660c91c1f1@tessares.net>
In-Reply-To: 71b1537ee313ad6a9338b676d09b727e03b49d4c.1605717967.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6783

--===============3709478549251713468==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 18/11/2020 17:47, Paolo Abeni wrote:
> Only mptcp_close() can actually cancel the workqueue,
> no need to add and use this flag.

Thank you for this fix ( :-D )!

Just added at the bottom of the tree:

- a72bd49026f0: mptcp: drop CANCEL_WORK status bit
- Results: 3c06d194dc8b..3507a038db26

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3709478549251713468==--
