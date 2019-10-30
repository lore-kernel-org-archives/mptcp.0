Content-Type: multipart/mixed; boundary="===============5148956295537441723=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/2] mptcp: add primitive scheduler
Date: Wed, 30 Oct 2019 16:17:30 -0700
Message-ID: <alpine.OSX.2.21.1910301603330.14540@magresha-mobl.amr.corp.intel.com>
In-Reply-To: 20191030140357.11880-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2361

--===============5148956295537441723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 30 Oct 2019, Florian Westphal wrote:

> This is a simplified version of a sendmsg ssk selection strategy,
> so sendmsg or retransmit could also occur on a backup subflow.
>
> In the initial submission it was pointed out that we should not
> send more data when a retransmission is happening.
>

I think I had a concern about starving the retransmit worker if userspace =

kept sending data, but on further thought it seems like the retransmit =

worker will get a chance to send eventually. Once the non-retransmit path =

in mptcp_sendmsg_frag() has to wait for memory due to unacked MPTCP-level =

data, the ssk transmit queue will empty out and retransmission will =

proceed.

While waiting for the queue to be completely empty at retransmit timeout =

time may lead to idling the link, it should not get permanently stuck, =

right? Or does the MPTCP-level accounting not work that way yet (given =

what you're planning with wmem_queued accounting)?

> As this isn't directly related to this I've decided to send those two
> patches now and work on sendmsg moderation next.
>
> The plan is to add wmem_queued accounting to the mptcp socket and
> then make sendmsg/mptcp_poll consider mptcp socket wmem limits to
> avoid sending more data if there are no mptcp-level acknowledgements.
>
> This however might take some time because msk->ack_seq update occurs only
> at recvmsg time and not during mptcp ack processing.
> For this to work properly, mptcp-level ack update should not depend on
> a recvmsg call.
>

This sounds like a good plan.

--
Mat Martineau
Intel
--===============5148956295537441723==--
