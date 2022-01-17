Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27348173
	for <mptcp@lists.linux.dev>; Mon, 17 Jan 2022 21:39:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1642455592; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=jreayqLM2xzgtyluexhUx51+WHF7fx+TzRW6MzUG/dXHNzPV1nWOUOLog2xq4UwxZiSfingIvuQ7xPT0Dy1wYWcuXDTku8wo0kBMwSkVCdmf8B1R/ZBUmhNBqUN7j5LmdKV0Lof1D4eb351Ga9kF58X8IBmf73kxTYyMY10KfnA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1642455592; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=mvX0aJeFV4SSsh0UYhgIKp7P/WP1t29SKH+2bDWp2EQ=; 
	b=cGTxXaT3nVdOmZ8xdk7oci8zP4XTZJ4uj0DRfIdsDrahrbz3Yfy6VT+mpBY+MPfxhx6ux6ybKvLS7rQV+0P3CHO4JFXDex8V8sgsDfxCgopEqBC3gCzyetDDh5n9IiANtrvwZjeolPzj9l3W2sHvjvH5TBD1UUFGhhEH+sV0COM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1642455592;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=mvX0aJeFV4SSsh0UYhgIKp7P/WP1t29SKH+2bDWp2EQ=;
	b=AoC7G6xCavqUNO005w589hULiWcq9rioBtlza+39LKNCQu6TLEbuU8zPM/Gi/eFg
	NVHH/G7Uk1f9C/SiNZPD5vE7scWUrn9aaaVTLBD9U4kiPQMvUu9AbsMRJmGRADRICc7
	fN8aiMr4fMEbYggodrTysdWK2rkJ93VHnjk8NqZ4=
Received: from [192.168.100.116] (vps-f3afed4e.vps.ovh.net [198.244.151.99]) by mx.zoho.eu
	with SMTPS id 1642455590296331.7469716168074; Mon, 17 Jan 2022 22:39:50 +0100 (CET)
Subject: Re: [PATCH net-next v2] net: mptcp, Fast Open Mechanism
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220116001259.203319-1-dmytro@shytyi.net>
 <449d3338d759e9f72f33e7c37e1b9956bdda77f4.camel@redhat.com>
From: Dmytro SHYTYI <dmytro@shytyi.net>
Message-ID: <449fb0ab-5155-114e-05dd-1f86a742dc4c@shytyi.net>
Date: Mon, 17 Jan 2022 21:39:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <449d3338d759e9f72f33e7c37e1b9956bdda77f4.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hello Paolo,


On 17/01/2022 09:58, Paolo Abeni wrote:
> Hello,
> 
> On Sun, 2022-01-16 at 00:12 +0000, Dmytro SHYTYI wrote:
>> This set of patches will bring "Fast Open" Option support to MPTCP.
>> The aim of Fast Open Mechanism is to eliminate one round trip
>> time from a TCP conversation by allowing data to be included as
>> part of the SYN segment that initiates the connection.
>>
>> IETF RFC 8684: Appendix B.  TCP Fast Open and MPTCP.
>>
>> [PATCH v2] includes "client-server" partial support for :
>> 1. MPTCP cookie request from client.
>> 2. MPTCP cookie offering from server.
>> 3. MPTCP SYN+DATA+COOKIE from client.
>> 4. subsequent write + read on the opened socket.
>>
>> This patch is Work In Progress and an early draft shared due community
>> request.
> 
> It looks like this is more far from an RFC status than I thought.

I agree.

> There are a number of tasks to be completed for that:
> - do not comment out existing working code, expecially TCP one.
> - split the patch in several small one, clearly documenting in the
> individual commit message what each patch is doing and why.
>    A possible skeleton could be:
>    * create the needed hooks in the TCP code, providing a dummy
>      implementation. Each hook will need a solid justification,
>      and they should not affect the TCP critical path.
>      The number of added hooks should be as low as possible.
>      You should try to use the existing hooking whenever it should be
>      possible.
>      No patch should touch the TCP code after the hooks are created.
>      Side note: I'm unsure if any additional hooks are really needed.
>    * add the real MPTCP impl, possibly with separate patches for
>      the client and the server side
>    * add self-tests
> - avoid introducing white-space only changes.

Thank you for sharing this. I'm going to take this into account. I might 
participate in the next MPTCP meeting to clarify some points.

> There are a bunch of specific inline notes below, which are still very
> important.

Thanks!

>> Signed-off-by: Dmytro SHYTYI <dmytro@shytyi.net>
>> ---
>>   include/linux/tcp.h             |  7 ++++
>>   net/ipv4/inet_connection_sock.c |  3 +-
>>   net/ipv4/tcp_fastopen.c         | 42 +++++++++++++++++++----
>>   net/ipv4/tcp_input.c            | 16 +++++----
>>   net/mptcp/protocol.c            | 59 ++++++++++++++++++++++++++++++---
>>   net/mptcp/sockopt.c             | 40 ++++++++++++++++++++++
>>   net/mptcp/subflow.c             | 14 ++++++++
>>   7 files changed, 162 insertions(+), 19 deletions(-)
>>
>>   
>>   /* TCP Fast Open Cookie as stored in memory */
>>   struct tcp_fastopen_cookie {
>> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
>> index f7fea3a7c5e6..4b4159c0258d 100644
>> --- a/net/ipv4/inet_connection_sock.c
>> +++ b/net/ipv4/inet_connection_sock.c
>> @@ -501,7 +501,8 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
>>   	req = reqsk_queue_remove(queue, sk);
>>   	newsk = req->sk;
>>   
>> -	if (sk->sk_protocol == IPPROTO_TCP &&
>> +	if ((sk->sk_protocol == IPPROTO_TCP ||
>> +	     sk->sk_protocol == IPPROTO_MPTCP) &&
>>   	    tcp_rsk(req)->tfo_listener) {
>>   		spin_lock_bh(&queue->fastopenq.lock);
>>   		if (tcp_rsk(req)->tfo_listener) {
> 
> This chunk is really not needed. mptcp invokes inet_csk_accept(),
> passing the initial subflow as the first argument. That socket is
> really a TCP one.

I agree.

> Cheers,
> 
> Paolo
> 
Best regards,
Dmytro
