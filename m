Content-Type: multipart/mixed; boundary="===============8436220600593541957=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp] mptcp: put subflow sock on connect error
Date: Mon, 22 Feb 2021 18:15:47 +0100
Message-ID: <68ee2196-9ba0-c667-317c-2ecafc46733a@tessares.net>
In-Reply-To: 20210217154205.7379-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7899

--===============8436220600593541957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat,

On 17/02/2021 16:42, Florian Westphal wrote:
> mptcp_add_pending_subflow() performs a sock_hold() on the subflow,
> then adds the subflow to the join list.
> =

> Without a sock_put the subflow sk won't be freed in case connect() fails.

Thank you for the patch and the review!

With a bit of delay, sorry for that, it is now in our tree with Mat's =

RvB tag:

- b2dc043f86c3: mptcp: put subflow sock on connect error
- Results: 253897668c44..356eae3ba43b

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8436220600593541957==--
