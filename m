Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD15173
	for <mptcp@lists.linux.dev>; Mon, 17 Jan 2022 09:01:35 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id 30so62656411edv.3
        for <mptcp@lists.linux.dev>; Mon, 17 Jan 2022 01:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=2Kkz3GfxazsiqCABYWt/PP+jPNWaLJwoq1WNaGrI+H8=;
        b=KFoFauOmutI130223UNIW7Mgmu4QYszv6ovOMmkAqBn5q26MD+PVMFUkDs7pciwRRx
         7u7fE6NX/aF/BtSdW5nzmt/Q4oxHBjJTas+VMBwvmio6ccSina/sPNS+BCWuwU5LhwYk
         vdfYOvvLuu6evTURBeIxumHS4wy4P9JZD6i+KOZVyIXSYx/Xkr7eaN9Ict+ualev49A/
         PkJFOOPH8s3UfKwGIo6RKvaWEf8fjExZuMiItJRmUMZHDfBcBGsDtNrTOn4I703vqU+j
         AssCVPLwVTDh7WpUvhbCaIM4X2EmrZv/lO4E4yp151xrT65l3NDAC455Rx/TvILR1ufl
         3LSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2Kkz3GfxazsiqCABYWt/PP+jPNWaLJwoq1WNaGrI+H8=;
        b=tpvk++qezOViBncg5Yes/knDVKS8C4QTahHh7gE5I9wKLNKbTEH9DCPOojD5JYffQH
         5hmNOI6U28r3C25aUz7CeyMJDCKv2Rzyz46mZFyv+y6LPu9enbS6J5Ai7iQuC0UfF6tr
         2/KGV8FOJsiv2fWp5l7XXCimh2l2A6IQNmySlWnGoxRWFZ7iuJbjEb+xG09PdkUNqSwd
         cQXGtKLxjVzvuASbY0mQAm0niuL12CnweEJZkKXdO3UNFmMNcex8oxI25K5PYeBM1+lA
         FIQr8pBrNiABh93qT9v1t2jq+jCwq6RHBg6f1YM52aJ9WwvUIwH/aoSu52ZAAbk/ASuq
         Qx/w==
X-Gm-Message-State: AOAM531ryu1XhZrGcWFyE9xdVJl28wU0z8RlGlT4/2OnX6CR9SEdu+IS
	vkvtMdhq7/CmyrYG/8bztr4NOHYRFSkbZg==
X-Google-Smtp-Source: ABdhPJxeXBiPkpdN1kzr9JcySqHrkVR73LfJxbxPBBN6gLEPeVLCGdQmGTcnDom9nm/ccxEfLFN+hw==
X-Received: by 2002:a17:906:ca0f:: with SMTP id jt15mr12019547ejb.424.1642410092950;
        Mon, 17 Jan 2022 01:01:32 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:d062:2656:aa4c:a3d0? ([2a02:578:8593:1200:d062:2656:aa4c:a3d0])
        by smtp.gmail.com with ESMTPSA id nd10sm4197222ejc.214.2022.01.17.01.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 01:01:32 -0800 (PST)
Message-ID: <7138d0a4-7118-481b-a88e-5232e9f951ec@tessares.net>
Date: Mon, 17 Jan 2022 10:01:32 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH net-next v2] net: mptcp, Fast Open Mechanism
Content-Language: en-GB
To: Dmytro SHYTYI <dmytro@shytyi.net>, mptcp@lists.linux.dev
References: <20220116001259.203319-1-dmytro@shytyi.net>
 <202201162148.bSZpItDM-lkp@intel.com>
 <5c970a8d-008c-059f-b263-c46ee9f1a29c@shytyi.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <5c970a8d-008c-059f-b263-c46ee9f1a29c@shytyi.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dmytro,

Thank you for sharing this new version.

On 16/01/2022 22:24, Dmytro SHYTYI wrote:
> Hello,
> 
> I think i fixed this locally but I'm not going to submit a new patch
> with a correction to avoid CI resource wasting. I wait until major change.
> If you think it might be interesting to upload a new patch with this
> minor change, please let me know.

Up to you. It is fine to submit a new version if you want more feedback
from the CI. It can also help for the reviews if people can apply the
patch on top of our "export" branch, please see below.

Just if you do re-submit, please add "RFC" next to "PATCH" in the title.


> sk_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, true);
> | ^~~~~~~~~~~~~~~~~~~
> | tcp_stream_alloc_skb
> 
> Also I'm curious as this patch is failed to apply to current master, but
> I don't know the reason (which conflict do I have?)... ...locally I
> successfully build this patch against: 5.16.0-rc8 met-next
> Auto-merging net/mptcp/subflow.cCONFLICT (content): Merge conflict in
> net/mptcp/subflow.c
> Auto-merging net/mptcp/sockopt.cCONFLICT (content): Merge conflict in
> net/mptcp/sockopt.c

Your patch should be on top of our "export" branch -- or the
'for-review' one, same content but a continuous Git history -- from our
repository on Github.

https://github.com/multipath-tcp/mptcp_net-next/wiki/Git-Branches

You can also see on Patchew it was not possible to apply your patch:

https://patchew.org/MPTCP/20220116001259.203319-1-dmytro@shytyi.net/

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
