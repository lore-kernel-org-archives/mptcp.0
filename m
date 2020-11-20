Content-Type: multipart/mixed; boundary="===============5110360717046377701=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] Squash-to: "mptcp: protect the rx path
 with the msk socket spinlock"
Date: Fri, 20 Nov 2020 18:14:51 +0100
Message-ID: <6f173353-8235-0d95-f9e6-f4e71da01991@tessares.net>
In-Reply-To: b1ff505e3dcff29eda4a2f3354c3a9d1223e4390.1605823023.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6880

--===============5110360717046377701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 19/11/2020 22:57, Paolo Abeni wrote:
> drop left-over splicing from the join list, we don't need
> it anymore there.

Thank you for the fix!

- abdb87ebc91b: "squashed" in "mptcp: protect the rx path with the msk =

socket spinlock"
- Results: 3e5b456bf2e8..580a33433a07

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5110360717046377701==--
