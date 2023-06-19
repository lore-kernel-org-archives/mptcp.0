Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27144D536
	for <mptcp@lists.linux.dev>; Mon, 19 Jun 2023 09:28:42 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2b479d53d48so8540601fa.1
        for <mptcp@lists.linux.dev>; Mon, 19 Jun 2023 02:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687166921; x=1689758921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vfkmu5cuB1pNP5xL5R0kLfcMecO69/OKJ9kN+IP/bbA=;
        b=TQar8EtM/RlVHae0XaCyI7JdmXAYTZXj8Tuxdy+W0JeLMkXVFrOGbpq2zv6XCs+yuM
         6OvsxR7c3cEe0KsO7W6IVmCE/fHxM5kx/fCCMahSUZiqOCFQ/8AK2TTmu8ta6x87Xu8M
         b75bbHa53B3c1L904/jF/TgvDJtZUbx+71/nBCC7BESHzGiSu2AbBenA1LHQXbYcbFPY
         1b1zTJuyViULRAyT8EwUry84OOe6SF4P8FGUVkHGBnwAf5CL3w158BMcoh4Th/AQNZFl
         s8mFfRNnRkxo9SSw+FQCESPn/S8QZrXfrG7MsCJ/4MhuovFxYa3shwFE67afkRTMtPkH
         QtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687166921; x=1689758921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vfkmu5cuB1pNP5xL5R0kLfcMecO69/OKJ9kN+IP/bbA=;
        b=dtoj+R2oZoHK8AhCo68vvkLXilSGDUbCNf+OMnN2W69MYG+ymSI32/3lrrciHL3tJE
         331LZeQNOUbM7uyZM2X1uRtB+NaW5Wg+IdVICWw6NeXQBSMrCYvrcpnpu9mLR7X1Fs9A
         bAuYR9jxtt7mZP56qsbjEh1KhMbY+HeXWuzHKJyeiv8aWBga0cVWxJXV5t37unn45V4A
         JV8TN1pZP+EdHKOaKmFU16OrgaQe1rqZlbtgGvg3mgS/5NzM9lwvB2i42YvR0nvijbmv
         q4ZMd7b4WoPOWjUfP+zHmtoeSPVmOO3+pYZ+iImbkf/KASR+PgVXIru2o96ZZdLVP96A
         Qf+A==
X-Gm-Message-State: AC+VfDzaRyVeKQb6lgu2XuSr5vAd5QoQcWedvV0OXGGhuhXLReP9KXsl
	2ApTmCTJAniptMJEpDlJU7U=
X-Google-Smtp-Source: ACHHUZ6SZykzNmpaFGnLLkoNzoEAuucs1owKHlQ1mFwMyzrnC8pJvMUfrCmeVd7N7DXvIQp1GNIimA==
X-Received: by 2002:a05:651c:1031:b0:2b4:5b65:c914 with SMTP id w17-20020a05651c103100b002b45b65c914mr4071058ljm.24.1687166920660;
        Mon, 19 Jun 2023 02:28:40 -0700 (PDT)
Received: from [192.168.43.77] (82-132-229-146.dab.02.net. [82.132.229.146])
        by smtp.gmail.com with ESMTPSA id n12-20020a7bc5cc000000b003eddc6aa5fasm10125005wmk.39.2023.06.19.02.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 02:28:40 -0700 (PDT)
Message-ID: <d9c9bd5f-b17e-fbd8-5646-4f51b927cc6b@gmail.com>
Date: Mon, 19 Jun 2023 10:28:30 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v2 1/4] net: wire up support for
 file_operations->uring_cmd()
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, Breno Leitao <leitao@debian.org>,
 io-uring@vger.kernel.org, axboe@kernel.dk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Matthieu Baerts <matthieu.baerts@tessares.net>,
 Mat Martineau <martineau@kernel.org>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Xin Long <lucien.xin@gmail.com>
Cc: leit@fb.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dccp@vger.kernel.org, mptcp@lists.linux.dev, linux-sctp@vger.kernel.org,
 ast@kernel.org, kuniyu@amazon.com, martin.lau@kernel.org,
 Jason Xing <kernelxing@tencent.com>, Joanne Koong <joannelkoong@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Willem de Bruijn
 <willemb@google.com>, Guillaume Nault <gnault@redhat.com>,
 Andrea Righi <andrea.righi@canonical.com>
References: <20230614110757.3689731-1-leitao@debian.org>
 <20230614110757.3689731-2-leitao@debian.org>
 <6b5e5988-3dc7-f5d6-e447-397696c0d533@kernel.org>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <6b5e5988-3dc7-f5d6-e447-397696c0d533@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/14/23 16:15, David Ahern wrote:
> On 6/14/23 5:07 AM, Breno Leitao wrote:
>> diff --git a/include/linux/net.h b/include/linux/net.h
>> index 8defc8f1d82e..58dea87077af 100644
>> --- a/include/linux/net.h
>> +++ b/include/linux/net.h
>> @@ -182,6 +182,8 @@ struct proto_ops {
>>   	int	 	(*compat_ioctl) (struct socket *sock, unsigned int cmd,
>>   				      unsigned long arg);
>>   #endif
>> +	int		(*uring_cmd)(struct socket *sock, struct io_uring_cmd *cmd,
>> +				     unsigned int issue_flags);
>>   	int		(*gettstamp) (struct socket *sock, void __user *userstamp,
>>   				      bool timeval, bool time32);
>>   	int		(*listen)    (struct socket *sock, int len);
>> diff --git a/include/net/sock.h b/include/net/sock.h
>> index 62a1b99da349..a49b8b19292b 100644
>> --- a/include/net/sock.h
>> +++ b/include/net/sock.h
>> @@ -111,6 +111,7 @@ typedef struct {
>>   struct sock;
>>   struct proto;
>>   struct net;
>> +struct io_uring_cmd;
>>   
>>   typedef __u32 __bitwise __portpair;
>>   typedef __u64 __bitwise __addrpair;
>> @@ -1259,6 +1260,9 @@ struct proto {
>>   
>>   	int			(*ioctl)(struct sock *sk, int cmd,
>>   					 int *karg);
>> +	int			(*uring_cmd)(struct sock *sk,
>> +					     struct io_uring_cmd *cmd,
>> +					     unsigned int issue_flags);
>>   	int			(*init)(struct sock *sk);
>>   	void			(*destroy)(struct sock *sk);
>>   	void			(*shutdown)(struct sock *sk, int how);
>> @@ -1934,6 +1938,8 @@ int sock_common_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>>   			int flags);
>>   int sock_common_setsockopt(struct socket *sock, int level, int optname,
>>   			   sockptr_t optval, unsigned int optlen);
>> +int sock_common_uring_cmd(struct socket *sock, struct io_uring_cmd *cmd,
>> +			  unsigned int issue_flags);
>>   
>>   void sk_common_release(struct sock *sk);
>>   
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index 1df7e432fec5..339fa74db60f 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
>> @@ -3668,6 +3668,18 @@ int sock_common_setsockopt(struct socket *sock, int level, int optname,
>>   }
>>   EXPORT_SYMBOL(sock_common_setsockopt);
>>   
>> +int sock_common_uring_cmd(struct socket *sock, struct io_uring_cmd *cmd,
>> +			  unsigned int issue_flags)
>> +{
>> +	struct sock *sk = sock->sk;
>> +
>> +	if (!sk->sk_prot || !sk->sk_prot->uring_cmd)
>> +		return -EOPNOTSUPP;
>> +
>> +	return sk->sk_prot->uring_cmd(sk, cmd, issue_flags);
>> +}
>> +EXPORT_SYMBOL(sock_common_uring_cmd);
>> +
> 
> 
> io_uring is just another in-kernel user of sockets. There is no reason
> for io_uring references to be in core net code. It should be using
> exposed in-kernel APIs and doing any translation of its op codes in
> io_uring/  code.

That callback is all about file dependent operations, just like ioctl.
And as the patch in question is doing socket specific stuff, I think
architecturally it fits well. I also believe Breno wants to extend it
later to support more operations.

Sockets are a large chunk of use cases, it can be implemented as a
separate io_uring request type if nothing else works, but in general
that might not be as scalable.

-- 
Pavel Begunkov
