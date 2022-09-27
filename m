Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5472FAE
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 15:11:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664291515; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=GJhHfEDRyWiMTxNKQsK4UbK1KQyXgftZRGc3XsuQu6rYbrSobmcrYMVayRTFtNpZrsupAmccQNvHJTfs9z4koLVw0a7QC27Inv6Blvur9c1FDo7sVgkkkurhj54wuomLV8Ldef4xi/AYPZ+IBksksTrST2o+3r7SPxjVNKPB4KE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664291515; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=6B0rFLn7Uf0ZTEGiUCVjBSRJPGLplHFeehyDxrDcx+0=; 
	b=GglplAgt1YzDbjkUzqIWeFlpmEzlrbsZxJwTGLXMn3hiQFZwDSrRaqrPW36Lbce2qLaspBAmLvLL9woXogKLR5yb+nc/iC3c5ONmAEVTKWu5mrglaaDSDbNPLW/dBDfxi/pv7mU827dd9G/d9hapU8/9qWjCrPVnyFiIcJj6LCs=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664291515;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=6B0rFLn7Uf0ZTEGiUCVjBSRJPGLplHFeehyDxrDcx+0=;
	b=YAAyqyK7txsXqqrueRc5AsoyZ3H4mM9qgzSgEhHWK+WZB038qnnCK6V3skw1Ej8l
	wsYSKvpw45v/T4tz2QZKXsd5RtfUT74+5oFozPAI35oxE5G5kdzXQkhU/Pq4Os9AzNL
	spfzNkL+01LSGZNefGcawrQcMm/ajrtNdQeXBhlw=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 166429151340536.99493976961469; Tue, 27 Sep 2022 17:11:53 +0200 (CEST)
Message-ID: <0d446a93-7cd1-1c34-099b-716e31c0054b@shytyi.net>
Date: Tue, 27 Sep 2022 17:11:52 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH mptcp-next v11 3/4] mptcp: add
 mptcp_subflow_conn_sock()
Content-Language: fr
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
References: <20220925232601.25252-1-dmytro@shytyi.net>
 <20220925232601.25252-4-dmytro@shytyi.net>
 <f132db08-8601-40d3-9477-ae914e96165a@tessares.net>
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <f132db08-8601-40d3-9477-ae914e96165a@tessares.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hello Matthieu,


On 9/26/2022 7:11 PM, Matthieu Baerts wrote:
> Hi Dmytro,
>
> On 26/09/2022 01:26, Dmytro Shytyi wrote:
>> In the following patches we will call mptcp_subflow_conn_sock() from
>> tcp_sendmsg_fastopen() in file "net/ipv4/tcp.c", thus make such symbol
>> visible.
> The patch description and title don't seem to be correct. You are doing
> more than that here.

Thanks, I deleted this patch in next version.


>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index 5702ca9b952d..a22c8044de17 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -1197,8 +1197,19 @@ static int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>>   		}
>>   	}
>>   	flags = (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
>> -	err = __inet_stream_connect(sk->sk_socket, uaddr,
>> -				    msg->msg_namelen, flags, 1);
>> +	if (!sk_is_mptcp(sk)) {
>> +		err = __inet_stream_connect(sk->sk_socket, uaddr,
>> +					    msg->msg_namelen, flags, 1);
> Do you think it could be possible not to modify tcp_sendmsg_fastopen()
> but instead implement '.connect' callback in 'mptcp_prot'?
>
>
>> +	} else {
>> +		struct sock *parent = mptcp_subflow_conn_sock(sk);
>> +
>> +		release_sock(sk);
>> +		release_sock(parent);
> It looks strange to release sockets because, I guess, they are going to
> be re-lock just after. It certainly means you want to call a (new)
> function which is not doing this locking bit, no?
No need to address this question, as I deleted this patch in new version.
> Cheers,
> Matt\

Thanks.

Dmytro.

