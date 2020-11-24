Content-Type: multipart/mixed; boundary="===============6588419987229190883=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2] mptcp: be careful on MPTCP-level ack.
Date: Tue, 24 Nov 2020 16:03:06 +0100
Message-ID: <5c49e00b65bd7ec96ad9fd8dc67fde9595a4eff3.camel@redhat.com>
In-Reply-To: 416cd9cc-944e-fe6e-e304-2ec8463b474d@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6900

--===============6588419987229190883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-11-24 at 15:25 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 24/11/2020 11:23, Paolo Abeni wrote:
> > We can enter the main mptcp_recvmsg() loop even when
> > no sublflows is connected. As note by Eric that would
> > result in a divide by zero oops on ack generation.
> > =

> > Address the issue checking the subflow status before
> > sending the ack.
> > =

> > Additionally protect mptcp_recvmsg() against invocation
> > with weird socket states.
> =

> Thank you for the patch!
> =

> Just added at the top of the tree:
> =

> - e7a463391127: mptcp: be careful on MPTCP-level ack
> - 85bdaa84e054: conflict in =

> t/mptcp-protect-the-rx-path-with-the-msk-socket-spinlock
> - af40879251c9: mptcp: adapt new code to topic
> =

> - Results: 7e538fe431fc..28691a4d4d0f
> =

> May you double check the conflicts resolution please? :)

LGTM,

Thanks!

/P

--===============6588419987229190883==--
