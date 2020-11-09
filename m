Content-Type: multipart/mixed; boundary="===============4487899178408148787=="
MIME-Version: 1.0
From: Dan Carpenter <dan.carpenter at oracle.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH][next] mptcp: fix a dereference of pointer before
 msk is null checked.
Date: Mon, 09 Nov 2020 17:57:58 +0300
Message-ID: <20201109145758.GP18329@kadam>
In-Reply-To: b5c267c1-f116-419c-92c9-88a56f9a3b51@canonical.com
X-Status: 
X-Keywords:                  
X-UID: 6603

--===============4487899178408148787==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2020 at 02:38:47PM +0000, Colin Ian King wrote:
> On 09/11/2020 14:36, Geliang Tang wrote:
> > Hi Colin,
> > =

> > Thanks for your patch. But this bug is reported by Dan Carpenter to MPT=
CP
> > ML earlier, and I have already sent out a fix in MPTCP ML for review. So
> > your fix is duplicated. I'm sorry.
> =

> Oh I missed Dan's fix. No problem, glad it is fixed. :-)

No, I didn't send a fix, just the bug report.  I normally don't send
bug reports to the kernel-janitors list.

regards,
dan carpenter

--===============4487899178408148787==--
