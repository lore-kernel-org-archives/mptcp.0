Content-Type: multipart/mixed; boundary="===============4631448454739969927=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] Squash-to "mptcp: refactor shutdown and close"
Date: Mon, 09 Nov 2020 18:32:16 +0100
Message-ID: <fd2ac81a-e1dc-f74a-c04c-c85e7c009045@tessares.net>
In-Reply-To: f4551b5fce944cf69dbbecbacf5ac354999b76fe.1604697929.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6610

--===============4631448454739969927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 06/11/2020 22:26, Paolo Abeni wrote:
> The msk status for fallback socket is not tracked correctly.
> We must switch to close only after the subflow is moved
> there, or the worker will not run and pending mptcp data
> will not be spooled after close()

Thank you for the patch and the review!

- a9dd786ca633: "squashed" in "mptcp: refactor shutdown and close"
- Results: 3f3a27631edd..42df929e2c92

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4631448454739969927==--
