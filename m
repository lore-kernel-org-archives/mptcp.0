Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D161C14
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 13:30:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663680629; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=JKzi32q67qQwuZKOctq/HbVvW7nRzGumEye0a06s8GVvydL1qBJkunUKhDe7B7uHBo1f+UMJUHnfeNhE9NwLVs0/lUsOtx04LyVS3hrhGoHQkm5V/BFpVY+P6yLX5K0Z84O06CU6e2Hqm91yRPQqPigj2bxw3KzWIUSxBQSQ/KU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663680629; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=c77AjBVSSfxEDMehOqzji44Tw4Tw5svS5BaY1kUgFok=; 
	b=DAbP7+TWKZ9aEVUpTOUTcwx+/tbW7wLHNukX2PvXJyn0By3uEvhXzO72GpTRf3GN3ku7BxBbTY4TcpGiUhLoGukQyUVwR10cVv6U3+vhZ+gkzuH7Ym0GinkQ9sSYXh8JekFOY2D4RlPomNDWsPq2Jdpjk1+fbjXz9ml4GCB1qlM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663680629;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=c77AjBVSSfxEDMehOqzji44Tw4Tw5svS5BaY1kUgFok=;
	b=DEorZEOo3ESiRocoM7H7mTspsaqdwZYgkfai14ElKHHMAQGAkpDl0tBNILmYB5if
	9mQANcnKECS4TV1+DSMEEmSeSHR1+MdHrJyg/5pKAXPzv2y8ORXu4gEkXbRXfBIJ9fB
	ZZS8ZCPOj674sUBTZeU1kyWh/Odfbvggxw1cUVcQ=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 16636806277351018.8545252619208; Tue, 20 Sep 2022 15:30:27 +0200 (CEST)
Message-ID: <50e1cd98-99d4-c33b-5784-f56377ef48af@shytyi.net>
Date: Tue, 20 Sep 2022 15:30:27 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH mptcp-next v7 02/11] add mptcp_stream_connect to
 protocol.h
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220917222853.2406-1-dmytro@shytyi.net>
 <20220917222853.2406-3-dmytro@shytyi.net>
 <5819cf0613ccb13db1c45d8f71bf5fc85d3b0ccf.camel@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <5819cf0613ccb13db1c45d8f71bf5fc85d3b0ccf.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Commit message was changed in v8.

Best,

Dmytro

On 9/19/2022 12:19 PM, Paolo Abeni wrote:
> On Sun, 2022-09-18 at 00:28 +0200, Dmytro Shytyi wrote:
>> We call mptcp_stream_connect() from mptcp_sendmsg_fastopen() in
> Minor nit: the commit message should be changed to something alike:
>
> """
> In the following patches we will call mptcp_stream_connect() [...],
> make such symbol visible.
> """
>
> Otherwise other reviewer may be confused.
>
> Thanks!
>
> Paolo
>
>> fastopen.c
>>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
>> ---
>>   net/mptcp/protocol.c | 4 ++--
>>   net/mptcp/protocol.h | 1 +
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 55442df8fb97..0e5db0a634d3 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -3474,8 +3474,8 @@ static void mptcp_subflow_early_fallback(struct mptcp_sock *msk,
>>   	__mptcp_do_fallback(msk);
>>   }
>>   
>> -static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>> -				int addr_len, int flags)
>> +int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>> +			 int addr_len, int flags)
>>   {
>>   	struct mptcp_sock *msk = mptcp_sk(sock->sk);
>>   	struct mptcp_subflow_context *subflow;
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index 1bc9f6e77ddd..1e21293bceaa 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -835,6 +835,7 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
>>   void mptcp_event_addr_announced(const struct sock *ssk, const struct mptcp_addr_info *info);
>>   void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
>>   bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
>> +int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr, int addr_len, int flags);
>>   
>>   static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
>>   {
