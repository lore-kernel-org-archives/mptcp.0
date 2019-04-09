Content-Type: multipart/mixed; boundary="===============5439023049520526595=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] memory accounting issue with current mptcp-proposal branch
Date: Tue, 09 Apr 2019 10:04:17 +0200
Message-ID: <8bbdf9b26bd78b9b188a7dd74fbf29817dff3e94.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1904081430360.5172@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 1057

--===============5439023049520526595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-04-08 at 14:33 -0700, Mat Martineau wrote:
> On Thu, 4 Apr 2019, Paolo Abeni wrote:
> =

> > Hi all,
> > =

> > I just checked-out the mptcp-proposal and did some tests vs a debug bui=
ld (CONFIG_KASAN and several CONFIG_*DEBUG* enabled).
> > =

> > I also have the local change reported at the bottom, just to made the s=
elf-test a little bit more stressing.
> > =

> > Running:
> > =

> > while true; do ./mptcp_connect.sh; done
> =

> Thanks Paolo. I can duplicate this warning, but haven't tracked down the =

> cause yet.

BTW, I can't reproduce it on top of the xmit pathes I've sent - I see
other issues, but that is another story. At least that tells the issue
should be in the current xmit path.

Cheers,

Paolo


--===============5439023049520526595==--
