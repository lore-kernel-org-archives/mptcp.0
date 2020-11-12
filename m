Content-Type: multipart/mixed; boundary="===============9001799812815818449=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 0/6] mptcp: just another complete
 datapath refactor
Date: Thu, 12 Nov 2020 11:57:32 +0100
Message-ID: <c5313bddfb2e9c0752b35f7d5fe29db81cf56fdb.camel@redhat.com>
In-Reply-To: b6ad516a-91b2-6ed1-baa0-15c036e26c78@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6684

--===============9001799812815818449==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-11-10 at 17:34 -0800, Mat Martineau wrote:
> On Tue, 10 Nov 2020, Paolo Abeni wrote:
> =

> > This series refactor once again the data path, with the
> > goal of avoding the worker usage for the fast path.
> > =

> > The worker will still be used to:
> > - cleanup closed subflows
> > - handle timeout
> > - retransmissions
> > - send the DATA_FIN/DATA_FIN ack.
> > - fallback eof
> > =

> > The latters 2 use case could be fourther removed, if we accept/consider
> > sending DATA_FIN/ack on a single subflow.
> =

> Sending DATA_FIN/ack on a single subflow looks ok to me in this case. =


Excellent! does that applies to the data_fin, too?

> It =

> would make sense to send that ack on the active subflow where incoming =

> data is being processed. On the workqueue that we didn't know which =

> subflow would be best to use, and didn't want to pick an inactive and =

> possibly-not-working subflow.

If we can send the data_fin on the subflow reaching the end of
sequence, we will not need anymore the workqueue to send the data_fin.
And the same for the data fin ack.

We will need the workqueue only for shutting down the subflows after
receiving the data_fin ack.

Cheers,

Paolo

[sorry, this mail got stuck in my mailbox the whole day]

--===============9001799812815818449==--
