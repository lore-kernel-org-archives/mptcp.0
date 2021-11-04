Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598CD2C85
	for <mptcp@lists.linux.dev>; Thu,  4 Nov 2021 14:18:23 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id f8so22096172edy.4
        for <mptcp@lists.linux.dev>; Thu, 04 Nov 2021 07:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=EYMNU1hvcFipmj7yY7HvVJCKUnGU6UxXayz+QrG7EbM=;
        b=JhRkkhwKmn9OwubN2fIT106CVPhr9AghMrJYD4HegPcqrOGYxmIvRAeDuoojzltomd
         Ns92lNsgFrdGhn1D6mmode1jTMzwTAYVbJjcZD11QJz7XGrTVnsj1Sn8CFggwv/PKD8b
         lnPjJmybmtyX2k0ZipV3qrIW71u+PlGIch3AtIBfDlisI37uEBTVXireLicU7f6J5rFQ
         r9DtXvXvchQvHEmScXGM4UvpKbOWcJRSt4MCQwEbrh835QkGnOLDeKhUG3HwgmSNuYlE
         a+1A90EOSQZSacgK59gLHb7RFPbqcctLTvF6H0KN0Cd8X6V/PBuMO7Bnr1fpKWONfA8X
         XEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=EYMNU1hvcFipmj7yY7HvVJCKUnGU6UxXayz+QrG7EbM=;
        b=8DuConlAT2uouh35D7iCmLzKbSp9zwXTAGnP0NSoS4AIzwNkw+7H9TjqAG358zTVXk
         6RxmfKpqU9E4koM+wnSBqkwuvWm5BH68d4HWulKqhYqOJKdO4HRIYHLleLxhnBnccxW8
         A0cEhyDmu/V8lsoWNQGmndz+4P+0rhVgqOoop6ysO+4vrGqaH4hIjy+K5nl/Dn1OG8jC
         zb/+igA3ZW4lTPZSYslHCH9WwHjh/ViRplTxhswCVSVc9zJS0aa9ICO11ZOS9vWfTblH
         uYgqHdA1AwpfdV+KZ6msSrJHKhrvLvojXb0fPEA/IzSnCESbbgPqRoNRd+lb4k3H7WLP
         vhUA==
X-Gm-Message-State: AOAM530g9K7sRVbYb26jr7Nqkgry+Min+aQxpvPF3HDSFlsWaI8hZqbO
	5PHRvw6hkYcb6ZOHZnOPYy3jYaBF8h1ST3tO
X-Google-Smtp-Source: ABdhPJwnIyA5XeoLqDLpd5Ej6gDal0kYxhXNlYbFp/3GYTdq6z9tASL727LgIUqewbwHSaFJwPUFkw==
X-Received: by 2002:a17:907:7785:: with SMTP id ky5mr61597140ejc.247.1636035501595;
        Thu, 04 Nov 2021 07:18:21 -0700 (PDT)
Received: from ?IPV6:2a02:578:85b0:e00:8bb4:2878:7380:649e? ([2a02:578:85b0:e00:8bb4:2878:7380:649e])
        by smtp.gmail.com with ESMTPSA id go17sm2590211ejc.76.2021.11.04.07.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 07:18:21 -0700 (PDT)
Message-ID: <9040905d-e13f-203b-2add-1d5421aadf40@tessares.net>
Date: Thu, 4 Nov 2021 15:18:20 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v2 mptcp-net 0/2] mptcp: fix MPJ 3rd ack retransmissions
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <cover.1635885975.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1635885975.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 02/11/2021 21:48, Paolo Abeni wrote:
> The first patch is from Eric, thus is correct ;)
> The 2nd one is much more doubtful, starting from the author ;)

:-P

> The individual commit messages should be descriptive enough. With these
> 2 patches the related, pending pktdrill test:
> 
> https://github.com/multipath-tcp/packetdrill/pull/70

There is one comment left on this PR. Should we merge it anyway?

> now complete successfully
> 
> v1 -> v2:
>  - fix from delegated action invocation in patch 2/2 (Mat)
> 
> Eric Dumazet (1):
>   mptcp: fix delack timer

@Paolo: I added your Acked-by on this one, no objection?

> Paolo Abeni (1):
>   mptcp: use delegate action to schedule 3rd ack retrans

Thank you for the patches and the reviews!

Now in our tree (fixes for -net) with Mat's RvB tag, without 2 typos
spotted by Mat and with 2 minor modifications to satisfy checkpatch
(spaces around '-' and max 100 chars per line):

- 0eeedc170fdf: mptcp: fix delack timer
- 232f203394ce: mptcp: use delegate action to schedule 3rd ack retrans
- Results: 6a2b7fa0be7c..c1d29ad013b4

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211104T141805
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
