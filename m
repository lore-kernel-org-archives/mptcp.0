Content-Type: multipart/mixed; boundary="===============5979663031835248345=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] LPC proposal draft
Date: Mon, 09 Jul 2018 10:36:51 -0700
Message-ID: <alpine.OSX.2.21.1807091013540.4438@zcayetan-mobl1.amr.corp.intel.com>
In-Reply-To: CAKuKrBmc+QmAnh7oEcAz8+szKgwnSidtWvjFhYm5GEu4YZ7T=g@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 678

--===============5979663031835248345==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 9 Jul 2018, Matthieu Baerts wrote:

> Hi Mat,
>
> On Fri, Jul 6, 2018 at 10:22 PM Mat Martineau
> <mathew.j.martineau(a)linux.intel.com> wrote:
>>
>>
>> Hello -
>>
>> Those of us in the weekly web conference yesterday discussed options for
>> a Linux Plumber's Conference networking track talk
>> (http://vger.kernel.org/lpc-networking.html). The deadline is coming up
>> very soon, on Wednesday, 11 July.
>>
>> Here's a draft proposal, please comment!
>>

Minor edits to the proposal are inline here - see discussion below:

>> """
>>
>> Implementing Multipath TCP (RFC-6824) requires both adding a layer =

>> above TCP and modifying the core in a number of places. The layer =

>> additions are relatively straightforward: adding a new IPPROTO_MPTCP =

>> protocol type, overriding existing callbacks from the IP layer, and =

>> adding to TCP option handling. But even after extensive efforts by our =

>> MPTCP upstreaming community to minimize changes to the TCP core there =

>> are a handful of modifications required in order to support MPTCP. =

>> Unlike protocols that layer cleanly entirely above TCP, MPTCP must =

>> integrate with low-level TCP operations involving receive windows, =

>> sending and receiving ACKs, and the RST and FIN signals. We will show =

>> where the TCP core will be affected, why the changes cannot be avoided, =

>> and what we have done to avoid impacting TCP performance.
>>
>> """
>
> Thank you for this draft proposal! That's a very good work for me!
>
> Should we introduce what is MPTCP and who is behind? Maybe something
> very short like this?
>
> """
>
> A community project is underway to add Multipath TCP (RFC-6824) to the
> upstream Linux kernel. An existing implementation already adds MPTCP
> support in the Linux kernel but this version, even if it is used in
> production by different (specialised) companies all over the world,
> cannot be upstreamed as it is due to its intrusiveness that needs to
> be reduced.
>
> """

I think we benefit from keeping the focus narrow (part of that is staying =

differentiated from our Netdev talk too). I agree we should add the =

RFC-6824 reference, and note that it's a community effort.

>
> Even if it is obvious for us, should we clearly mention at the end
> that we are looking for discussions after that? Maybe something like
> this to reuse David's words?
>
> """
>
> We will show an architecture design proposal where the TCP core will
> be affected, why the changes cannot be avoided, and what we have done
> to avoid impacting TCP performance. We are looking forward to have
> face-to-face discussions and debate.
>
> """
>
> What do you think about that? Note that it is fine for me to send it
> as it is, my additions are mainly linked to details!

The discussion/debate part is assumed, I think :)

>
> Christoph also told me this morning that this version is good for him
> and if we want, we can send it as it is without waiting for the last
> day!
>

I'm uneasy about sending on the 11th: "Proposal submissions are due by =

July 11th 2018" leaves it unclear whether they mean "due before July 11th =

begins" or "due before end-of-day on July 11th". Sending today or tomorrow =

seems best.

Thanks,

--
Mat Martineau
Intel OTC

--===============5979663031835248345==--
