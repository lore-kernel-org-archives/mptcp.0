Content-Type: multipart/mixed; boundary="===============2242075560067447490=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: sendmsg: fix stream corrution
Date: Tue, 24 Sep 2019 08:55:44 +0200
Message-ID: <793afb461fa8a3ed9a0dbcf2bef400449ae8e8cd.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1909231632230.9738@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 1909

--===============2242075560067447490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-09-23 at 16:35 -0700, Mat Martineau wrote:
> On Mon, 23 Sep 2019, Matthieu Baerts wrote:
> On 23/09/2019 09:46, Paolo Abeni wrote:
> > > On Fri, 2019-09-20 at 15:45 -0700, Mat Martineau wrote:
> > > > Thanks for the detailed description. Code looks good to me and test=
ed fine
> > > > (although failures remain, but I don't think this was intended to f=
ix
> > > > everything).
> > > =

> > > I haven't seen any failure on top of this patch (plus recvmsg
> > > refactor), could you share debug enabled dmsg and/or pcap trace for
> > > failure you see?
> > =

> > I also saw failed tests but everything was fixed once "recvmsg refactor"
> > was applied too!
> =

> I re-ran the tests with both patch sets, and all pass. Sorry for the =

> false alarm - I had simply grabbed the export branch and applied the =

> series.

Nice! thank you for the confirm! =


Note: I think/I'm pretty sure there is still at least another possible
stream/data corruption pending into the current code base - see my
previous email for the details - but so far I was unable to
programmatically trigger it - likely pktdrill should help there.

Anyhow, given the difficulty to trigger it and amount of pending tasks,
I don't plan to try to address such issue in the short term.

Cheers,

Paolo


--===============2242075560067447490==--
