Content-Type: multipart/mixed; boundary="===============1925604466006266757=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: protect the
 rx path with the msk socket spinlock": a small cleanup
Date: Wed, 25 Nov 2020 12:34:40 +0100
Message-ID: <90c762bc-5e50-ef9a-9d1d-1237f23cac94@tessares.net>
In-Reply-To: f34d3d0783b1daa26e3491ffb92a4b5096db76df.1606101185.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6927

--===============1925604466006266757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 23/11/2020 04:13, Geliang Tang wrote:
> Since the local variable sk is defined, use it instead of open-coding.

Thank you for the cleanup!

- 0439eb029552: "squashed" in "mptcp: protect the rx path with the msk =

socket spinlock"
- 2fef4d92d6d7: "Signed-off-by" + "Co-developed-by"

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1925604466006266757==--
