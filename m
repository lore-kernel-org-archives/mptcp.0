Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BC570
	for <mptcp@lists.linux.dev>; Mon,  7 Jun 2021 15:13:09 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id l1so27274362ejb.6
        for <mptcp@lists.linux.dev>; Mon, 07 Jun 2021 08:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RZEh5c2Bb+QiFsZPfk5xtE3W7nLgSXT54cCiu9ABpW8=;
        b=bOxt90vDjjZDGU28pUqPOn+PvSMgOxCi4JvEVMgx78FEQNFfUZGlV2lU+kFnhvvj0N
         5lv7tADGas83Xe0Ap32mFaPro03w0Jy+p+EoGQO0FR6Xl41JIZeG/v23X3L8hVqy2Khr
         ixMGKAl6/mQESIyMZCuyaNAuwatppf/+QU+LgszArwl6zP6ncgnzaEhyAx49BJe7knbW
         rslRMMseSkMQcXuiWt9+usqGInplILs+czSrENdPabZxkbmAEN9bLqmLTaNF/N8FRfmB
         ng5AYePFzlKGAvQpfBcR4XvG0695D8Zb9vxCs6oTtcox3ufjbewoCnGEZXpmgcyV0ven
         pVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RZEh5c2Bb+QiFsZPfk5xtE3W7nLgSXT54cCiu9ABpW8=;
        b=ss68nT6SeyRgDzytyOAHB7jc2Yq2SbKVw1p/wHOOuR+9ifHf+moB+i8Bcd7u0bHcWZ
         lruOa8uUj0NXI87ND2Khj9WbyUIQxkIQRzH+5NkQldjIs1TK4/8GJuvHJZifvHMaV9Iw
         +z/xLsriTd73jI0jYO8ah4GUfEjeZpQuZcU/Pbbu0bSYaWVMJGc7FHw2cUoj5LZqFD8R
         /we34t9JIdQFGJusSrIsBS4ZySHNPRoozzULgx6iZQlSJLlIZ/3GcMtUa/gwPns1U0Q7
         fGqtW1POiwdm1w7IeCWIS10R+OCbIY+ijUQSaBMN/asiP860EKA8f5a93PN7CITsWqNj
         Z0uA==
X-Gm-Message-State: AOAM533fTdhyysrg2Y6oEGhfaw9fBodEbchno1HZgNLKYxVXOCWCyB3O
	siZmjOZhfSakDITdnmgfkp6ly6Bni19YlaMK
X-Google-Smtp-Source: ABdhPJwXV17fchrTuZfSCeJzBYa8kk2NjomvQr7Lyvn558MX9e8SdQHQnSGSz+mP1+Ceqr7Ku17xHg==
X-Received: by 2002:a17:906:eca7:: with SMTP id qh7mr18692879ejb.143.1623078787646;
        Mon, 07 Jun 2021 08:13:07 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:b57e:3c04:9ae7:cda2])
        by smtp.gmail.com with ESMTPSA id d24sm7827238edp.7.2021.06.07.08.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 08:13:07 -0700 (PDT)
Subject: Re: [PATCH mptcp-next 0/2] mptcp: some smaller cleanup
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <cover.1622132917.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <3ff6e57f-11b8-70e5-592b-3a995f89a7de@tessares.net>
Date: Mon, 7 Jun 2021 17:13:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1622132917.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 27/05/2021 18:53, Paolo Abeni wrote:
> This are 2 smallish pre-req for the RX path refactor.
> 
> I think they can live of their own merit, so sending them
> out now.
> 
> Paolo Abeni (2):
>   mptcp: don't clear MPTCP_DATA_READY in sk_wait_event()
>   mptcp: drop rendundant test in move_skbs_to_msk()

Thank you for the patches and the review!

Now in our tree:

- 8fefe3b1f9ec: mptcp: don't clear MPTCP_DATA_READY in sk_wait_event()
- 61f6d7b1a174: mptcp: drop rendundant test in move_skbs_to_msk()
- Results: e6629296aed2..a4f45379c78f

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210607T151231
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210607T151231

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
