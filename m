Content-Type: multipart/mixed; boundary="===============2899613913209053515=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 00/13] mptcp: improve multiple xmit
 streams support
Date: Sun, 15 Nov 2020 16:46:43 +0100
Message-ID: <19f4f533db68a3449c7f7f13734c6f776f01235f.camel@redhat.com>
In-Reply-To: 20201114130543.426c5a60@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com
X-Status: 
X-Keywords:                  
X-UID: 6732

--===============2899613913209053515==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 2020-11-14 at 13:05 -0800, Jakub Kicinski wrote:
> On Thu, 12 Nov 2020 18:45:20 +0100 Paolo Abeni wrote:
> > This series improves MPTCP handling of multiple concurrent
> > xmit streams.
> =

> Umpf, looks like it no longer applies after the net->net-next merge.
> Please respin.

Strange: I just rebased by local tree git did not complain here. Anyhow
I'll post a v3, including the checkpatch fix on patch 1/13.

Thanks,

Paolo

--===============2899613913209053515==--
