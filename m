Content-Type: multipart/mixed; boundary="===============0320750292956032134=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH 1/4] mptcp: use sk_page_frag() in sendmsg
Date: Mon, 08 Apr 2019 11:20:59 -0700
Message-ID: <alpine.OSX.2.21.1904081113080.4166@mjmartin-mac01.local>
In-Reply-To: 212fa3436ce97a51dbc98b9a588559344060379c.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1055

--===============0320750292956032134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Apr 2019, Paolo Abeni wrote:

> Hi,
>
> On Fri, 2019-04-05 at 15:17 -0700, Mat Martineau wrote:
>> @@ -80,33 +80,32 @@ static int mptcp_sendmsg(struct sock *sk, struct msg=
hdr *msg, size_t len)
>>> 		goto put_out;
>>> 	}
>>>
>>> -	/* Initial experiment: new page per send.  Real code will
>>> -	 * maintain list of active pages and DSS mappings, append to the
>>> -	 * end and honor zerocopy
>>> -	 */
>>> -	page =3D alloc_page(GFP_KERNEL);
>>
>> Allocating a new page per send is very inefficient for small sends, but
>> was a placeholder for managing an MPTCP-level send buffer.
>>
>> For each connection, we have one MPTCP-level socket, and some number of
>> subflow sockets that it controls. Sent data needs to be stored by the
>> MPTCP-level socket until it sees a relevant MPTCP DATA_ACK from any one =
of
>> the subflows and can purge the ack'd data.
>>
>> To meet that requirement, the idea was to have the MPTCP-level socket
>> buffer the send data in a set of pages. Each sendmsg() call would append
>> to the current page while space is available, so each page would fill wi=
th
>> contiguous data (in the MPTCP sequence space). If data was sent with
>> MSG_ZEROCOPY the userspace-provided pages would be used instead. The
>> buffered data could then be sent (or resent) on multiple subflows by usi=
ng
>> do_tcp_sendpages() to create independent skbs referencing the one
>> MPTCP-level copy of the data.
>>
>> For example:
>>
>>   * Userspace sends 1024 bytes of data
>>
>>   * MPTCP-level socket copies 1024 bytes to a page
>>
>>   * Four separate skbs are built, referencing the same page and offset f=
or
>> the 1024 bytes
>>
>>   * Each of the four skbs is near-simultaneously queued on a separate
>> subflow
>>
>>   * One subflow is faster than the others, and gets the data sent and
>> DATA_ACK'd quickly
>>
>>   * MPTCP-level socket releases the buffer page (but the data might still
>> be referenced by a queued skb on a slow subflow)
>>
>> As a first step with a single subflow, I kept it simple by allocating one
>> page per send and  keeping track of that page in the MPTCP-level
>> socket.
>
> Thank you for the detailed feedback.
> To double check I'm no the same page: most/all of the above
> infrastructure and features are missing in the current code base.

That's correct.

>
> I *think* they could be added on top of this series with some
> changes...

Ok, good! I was hoping the additional background would help make design =

choices at this stage rather than after you have done a lot more work.

>
>>> -	if (!page) {
>>> -		ret =3D -ENOMEM;
>>> -		goto put_out;
>>> +	lock_sock(sk);
>>> +	lock_sock(ssk);
>>> +
>>> +	/* use the subflow page cache so that memory accounting is coherent */
>>> +	pfrag =3D sk_page_frag(ssk);
>>
>> Given the plan to keep the paged data buffered by the MPTCP-level socket,
>> is sk_page_frag() the best way to get a page that might be used for skbs
>> in multiple subflows?
>
> ... but some additional data structure would be needed (RB-tree for the
> pending page fragments ?!?) ...

Right.

>
>> Can memory accounting work properly if the page frag comes from sk (the
>> MPTCP-level socket) instead of ssk?
>
> AFAICS, it should. I have not tested it.
>
> Yep, using sk's page frag should be better.
>
> I'll try to give it a spin, unless you prefer a different approach.
>

This looks like a good approach to me. Thanks!

--
Mat Martineau
Intel

--===============0320750292956032134==--
