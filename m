Content-Type: multipart/mixed; boundary="===============0860340117989398798=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC mptpcp-next] mptcp: add ooo prune support
Date: Fri, 09 Oct 2020 09:35:02 -0700
Message-ID: <alpine.OSX.2.23.453.2010090925001.74568@plasker-mobl1.amr.corp.intel.com>
In-Reply-To: 20201009111119.GD5723@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 6273

--===============0860340117989398798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 9 Oct 2020, Florian Westphal wrote:

> Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
>> On Fri, 2 Oct 2020, Florian Westphal wrote:
>>
>>> It might be possible that entire receive buffer is occupied by
>>> skbs in the OOO queue.
>>>
>>> In this case we can't pull more skbs from subflows and the holes
>>> will never be filled.
>>>
>>> If this happens, schedule the work queue and prune ~12% of skbs to
>>> make space available. Also add a MIB counter for this.
>>>
>>> Signed-off-by: Florian Westphal <fw(a)strlen.de>
>>> ---
>>> Paolo, this does relate a bit to our discussion wrt. oow
>>> tracking.  I thought we might need to add some sort of cushion to
>>> account for window discrepancies, but that might then get us
>>> in a state where wmem might be full...
>>>
>>> What do you think?
>>>
>>> I did NOT see such a problem in practice, this is a theoretical "fix".
>>> TCP has similar code to deal with corner cases of small-oow packets.
>>>
>>
>> Is there a benefit to relying on the workqueue to discard skbs from the =
ooo
>> queue rather than handling that as data is moved from the subflows?
>
> It seemed simpler to do it this way.  When data_ready callback is
> running its the first spot where we make checks wrt. buffer occupancy.
>
> move_skbs_to_msk() (which is called right after) may not be able to
> acquire the msk lock.  I did not consider this performance critical to
> deal with both 'can do it inline' and 'need to defer to worker' cases.
>

Ok, makes sense.

>> The cause of "holes" in MPTCP reassembly is a little different from TCP,
>> since TCP takes care of the packet loss problem it seems to me the main
>> issue is recovering from path loss (assuming the window and rcv buffer s=
izes
>> are sane). We need to keep pulling from the subflows to potentially fill=
 the
>> holes, and the most valuable data to make progress would be earlier in t=
he
>> sequence space. We potentially throw less away if discarding later-seque=
nce
>> ooo queued skbs as subflow data arrives rather than doing the whole 12.5%
>> chunk, and don't have the latency of waiting for the workqueue to get
>> scheduled.
>
> Hmmm, thats true. OTOH I never obsevered this from happening, so I just
> went for a 'compact' patch.  Not sure it makes sense to optimize this.
>

I do wonder if different packet schedulers might run in to this more, but =

agree that there isn't evidence to justify optimizing now. If we merge =

this (or similar) we will have the MIB counter to help understand how much =

it does happen.

--
Mat Martineau
Intel
--===============0860340117989398798==--
