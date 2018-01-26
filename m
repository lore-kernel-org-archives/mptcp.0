Content-Type: multipart/mixed; boundary="===============9076560185126359039=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] TCP options framework and MD5 patch set
Date: Fri, 26 Jan 2018 10:58:36 -0800
Message-ID: <20180126185836.GZ5151@da0602a-dhcp225.apple.com>
In-Reply-To: alpine.OSX.2.21.1801251418110.28492@mjmartin-mac01.sea.intel.com
X-Status: 
X-Keywords:                  
X-UID: 299

--===============9076560185126359039==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 25/01/18 - 14:46:00, Mat Martineau wrote:
> On Thu, 25 Jan 2018, Christoph Paasch wrote:
> > On 25/01/18 - 11:41:53, Mat Martineau wrote:
> > > Thanks again for posting the RFC patch set to netdev in December. In =
case
> > > folks on this mailing list missed it, here's the link:
> > > =

> > > https://www.spinics.net/lists/netdev/msg472988.html
> > > =

> > > Other than the license information change, are you considering any ot=
her
> > > modifications?
> > =

> > no, not really. I was planning to get some performance numbers. But cou=
ldn't
> > get to it because of other unrelated urgencies that took my time.
> > =

> > > I suggest modifying the last section of the cover letter (the part st=
arting
> > > with "One point of discussion...") for the next round:
> > > =

> > > """
> > > There is still work to be done to more efficiently check for extra TCP
> > > options in performance-sensitive code paths. A rate-limited static ke=
y would
> > > nearly eliminate overhead if no extra TCP options are in use system-w=
ide, or
> > > a flag in a likely-hot cache line could work well.
> > > =

> > > For now we opted for a simple if (unlikely(!hlist_empty(...)) check.
> > > """
> > =

> > That sounds good!
> > =

> > =

> > What do you suggest - should we simply resubmit the RFCs as v2 with the
> > minor changes? (the timing of the first submission was probably fairly =
bad
> > as most people were out on Christmas vacation)
> > =

> =

> Yes, v2 with the minor changes is the way to go. The timing should be bet=
ter
> - Eric has been reviewing patches and recent RFCs in the archives seem to
> have a few replies.

Indeed! I wanted to get to this here right after the vacation, but things
have been crazy here in the office.

> I looked around the git history to see if anyone would obviously be
> interested from a TCP md5sig perspective. The only recent contributor I
> found (besides Eric) was Ivan Delalande, see commit c03fa9bcac. Maybe he
> would be good for the cc list.

Good point, I will add him to the CC-list.


Christoph


--===============9076560185126359039==--
