Content-Type: multipart/mixed; boundary="===============5460939553240348248=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC mptpcp-next] mptcp: add ooo prune support
Date: Thu, 08 Oct 2020 17:29:10 -0700
Message-ID: <alpine.OSX.2.23.453.2010081702580.49214@ozore-mobl2.amr.corp.intel.com>
In-Reply-To: 20201002154535.28412-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6263

--===============5460939553240348248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Oct 2020, Florian Westphal wrote:

> It might be possible that entire receive buffer is occupied by
> skbs in the OOO queue.
>
> In this case we can't pull more skbs from subflows and the holes
> will never be filled.
>
> If this happens, schedule the work queue and prune ~12% of skbs to
> make space available. Also add a MIB counter for this.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> Paolo, this does relate a bit to our discussion wrt. oow
> tracking.  I thought we might need to add some sort of cushion to
> account for window discrepancies, but that might then get us
> in a state where wmem might be full...
>
> What do you think?
>
> I did NOT see such a problem in practice, this is a theoretical "fix".
> TCP has similar code to deal with corner cases of small-oow packets.
>

Is there a benefit to relying on the workqueue to discard skbs from the =

ooo queue rather than handling that as data is moved from the subflows?

The cause of "holes" in MPTCP reassembly is a little different from TCP, =

since TCP takes care of the packet loss problem it seems to me the main =

issue is recovering from path loss (assuming the window and rcv buffer =

sizes are sane). We need to keep pulling from the subflows to potentially =

fill the holes, and the most valuable data to make progress would be =

earlier in the sequence space. We potentially throw less away if =

discarding later-sequence ooo queued skbs as subflow data arrives rather =

than doing the whole 12.5% chunk, and don't have the latency of waiting =

for the workqueue to get scheduled.

(I should look at the multipath-tcp.org kernel to understand how it's done =

there but I haven't had a chance to do that yet)

--
Mat Martineau
Intel
--===============5460939553240348248==--
