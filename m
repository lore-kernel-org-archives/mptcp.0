Content-Type: multipart/mixed; boundary="===============5484215716144419718=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3] mptcp: Basic single-subflow DATA_FIN
Date: Tue, 26 Nov 2019 19:39:19 -0800
Message-ID: <0ffcef214516d5478455cd6745e312352b498fd5.camel@linux.intel.com>
In-Reply-To: 00b46db3-f865-c18d-2d13-13b4986a9d86@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2699

--===============5484215716144419718==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Matt -

On Tue, 2019-11-26 at 10:07 +0100, Matthieu Baerts wrote:
> Hi Mat, Paolo,
> =

> On 25/11/2019 18:00, Paolo Abeni wrote:
> > On Fri, 2019-11-22 at 15:01 -0800, Mat Martineau wrote:
> > > Send a DATA_FIN along with any subflow TCP FIN flag when the MPTCP
> > > socket is closing or shutting down writes.
> > > =

> > > Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> > =

> > The patch LGTM, thanks!
> =

> Thank you for the new version and the review!
> =

> Where can I apply it? I would like to apply it just before the =

> introduction of the kselftests but please tell me if it is better to =

> squash it / apply it somewhere else.

Mat is out this week. I've checked that the changes to options.c and
protocol.c can be squashed to 'Write MPTCP DSS headers to outgoing data
packets' and the changes to subflow.c squash to 'Implement MPTCP receive
path'.

Peter.



> Cheers,
> Matt

--===============5484215716144419718==--
