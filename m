Content-Type: multipart/mixed; boundary="===============4182008977080128563=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: be careful on subflow creation
Date: Tue, 04 Aug 2020 21:25:44 +0200
Message-ID: <4f2a74b9-d728-fa76-7b0f-f70c256077ee@tessares.net>
In-Reply-To: 61e82de664dffde9ff445ed6f776d6809b198693.1596558566.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5474

--===============4182008977080128563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 04/08/2020 18:31, Paolo Abeni wrote:
> Nicolas reported the following oops:

(...)

> on some unconventional configuration.
> =

> The MPTCP protocol is trying to create a subflow for an
> unaccepted server socket. That is allowed by the RFC, even
> if subflow creation will likely fail.
> Unaccepted sockets have still a NULL sk_socket field,
> avoid the issue by failing earlier.
> =

> Reported-and-tested-by: Nicolas Rybowski <nicolas.rybowski(a)tessares.net>
> Fixes: 7d14b0d2b9b3 ("mptcp: set correct vfs info for subflows")

Thank you for the patch, the addition in the code looks very good to me!

But are you sure the commit you mention introduces the issue you fix here?

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4182008977080128563==--
