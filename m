Content-Type: multipart/mixed; boundary="===============2015677757989175858=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] LPC 2019 Call for Microconferences and Refereed-Track
 Proposals
Date: Wed, 22 May 2019 12:58:00 +0200
Message-ID: <99434bed-7147-04e2-a888-8866ceeb09f9@tessares.net>
In-Reply-To: alpine.OSX.2.21.1905211651200.13454@cwhilton-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1217

--===============2015677757989175858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 22/05/2019 02:04, Mat Martineau wrote:
> =

> On Tue, 21 May 2019, Matthieu Baerts wrote:
> =

>> Hi Paolo,
>>
>> On 21/05/2019 16:08, Paolo Abeni wrote:
>>> On Tue, 2019-05-21 at 13:44 +0200, Matthieu Baerts wrote:
>>>> A few weeks or months ago, we talked about (maybe) participating to LPC
>>>> 2019. The Linux Plumbers Conference for 2019 has been set for September
>>>> 9-11 at the Corinthia Hotel in Lisbon, Portugal.
>>>
>>> Indeed I agree that an MPTCP talk/paper there would be very nice.
>>
>> Great! Thank you for your support!
>>
> =

> Yes, it would be great to assemble a MPTCP presentation for the
> networking track!
> =

>>>> One of my colleague just pointed me out that the Call for Proposals is
>>>> open and the submission deadline is scheduled for the 23rd of May at
>>>> 05:30 (my time I guess). Less than 48h from now then.
>>>>
>>>> https://www.linuxplumbersconf.org/event/4/abstracts/
>>>
>>> AFACIK the networking CfP is not yet out _and_ there will be a
>>> networking CfP. MPTCP could fit that too, so there is almost for sure a
>>> little more time (even if an undefined amount;)
>>
>> Good point!
>>
>> Just found this on Twitter that seems to confirm that:
>> https://twitter.com/davem_dokebi/status/1130579316444549120
>>
>>> Assembling the most bad ass technical committee for the networking
>>> track of LPC 2019 in Lisbon, Portugal. You won't want to miss this.
>>> #lpc2019
>>
>> Followed by:
>>
>>> That track hasn't done their CFP either... Coincidence?!?!
>>
>> So the current CfP will not accept any networking talks, no need to send
>> anything now, right?
>>
> =

> Right (as far as I understand).

One of my colleague had the opportunity to talk to Kate Steward about
that and David Miller told her:

  Kate, I have just started assembling the technical committee for the
  networking track and once that is done we will discuss how we want to
  handle submissions.

So it seems safe to wait for this Networking CfP!

> For reference, here's what I submitted last year:

Thank you for this, that will be useful!

> https://lists.01.org/pipermail/mptcp/2018-July/000678.html
> =

> """
> Title: Multipath TCP integration with Linux TCP
> =

> Submitters: Mat Martineau, Christoph Paasch, Mattheiu Baerts, Peter

Oh, you spelled my name Mattheiu, that's probably why we were not
accepted... :-D (no worries ;-) )

> Krystad, Ossama Othman
> =

> Implementing Multipath TCP (RFC-6824) requires both adding a layer above
> TCP and modifying the TCP core in select places. The layer additions are
> relatively straightforward: adding a new IPPROTO_MPTCP protocol type,
> overriding existing callbacks from the IP layer, and adding to TCP option
> handling. But even after extensive efforts by our MPTCP upstreaming
> community to minimize changes to the TCP core there are a handful of
> modifications required in order to support MPTCP. Unlike protocols that
> cleanly layer entirely above TCP, MPTCP must integrate with low-level TCP
> operations involving receive windows, sending and receiving ACKs, and the
> RST and FIN signals. We will show where the TCP core would be affected,
> make a case for why the changes are justified, and explain what we have
> done to avoid impacting TCP performance.
> """
> =

> This did not get accepted, so that's probably a sign that we should try
> something a little different. On the other hand, if there's a separate
> BPF track maybe we have a better chance :)

Good point :)
I think we also sent it just before the end of the submission period and
we just had a talk about this topic at Netdev 0x12 about this.

I hope we will be able to say here that before September, RFC patches
will be sent to netdev ML.

Cheers,
Matt


> =

> -- =

> Mat Martineau
> Intel

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============2015677757989175858==--
