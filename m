Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7113670
	for <mptcp@lists.linux.dev>; Sat,  5 Jun 2021 09:18:31 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id b11so13938648edy.4
        for <mptcp@lists.linux.dev>; Sat, 05 Jun 2021 02:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:references:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EBD9U8d3Tblnvd98LgfLQPd/31DZc3z78klXXSRNtb4=;
        b=LpRDzPba2wOkdoYoaKsybQ8cHmTwnaX/wWk7KzUzS2nt/H1s+1FQ4t4yhwmVFwsKsP
         IvXcrOuobAM7LAM5hsmG3Migdvo0vlV5etVhVulJfe3Xf0tzn73W55IO/96HjKyUIkCE
         c/NjOLFNKELwF/xHwFuGIYFK8Mtaxw0sKLCdpon6noOobhromaxnZh6p91y4L835Xu3S
         HHyuUN8D17Ks2jWtW/5mqZcWeBCtHwiK8DupActQm+hj3ZUr7Hdkqgv6ATsUHDJ/Qu/J
         N89y4pMApO65vi4sJSfQ2Ymi/dUcWYF6rhIjNFx7/zZemztGGocMEmILvOyE0EgXZQxy
         BXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EBD9U8d3Tblnvd98LgfLQPd/31DZc3z78klXXSRNtb4=;
        b=bEFw9E8qdI0nNlIPA+NKztUM6GaqQoUCVCCPaQUiInaFPDTYubxzFJ7RVUaxmTQmYG
         YLAjZEcVRUBbelsZcyw+Rrps31KT3+ZU8X79bT3/B4ZIQqrEFQXMuW86Or3i1oapFEr6
         AhdlrA+cixIZ4x5uFw3vcC9XbfWxpIFhStriDaYq7JZDP/vcKVwSaCz8FvDUY6lphfOk
         Vbvl//Q0C++UW+z0y+6q+Q5PxGsjgK1gtZ2tH0ThArgHUKsRPGUC7RkrnyZfb2joTgA1
         1tHsgEPlsDzXzctPuGeUaCY/AZLHpC/M0yWeZo47jCvAOd4JB5TMMxAp/1ue7CzgvViz
         gvFQ==
X-Gm-Message-State: AOAM5302IkYPcnnyK4EbH2M47lswf6AlvBhC7AymzjOogodS4LCVZyFS
	4ZVNlCNVXfDDKiiBPvlQI6sADZcDr0FUCWjDQdA=
X-Google-Smtp-Source: ABdhPJyDdmVHYiUAK8RF4hZmZymxmdGv8oMhRhAlNFueaYa7xqYSg8psygeLGOC67fN0aXHS65wrRA==
X-Received: by 2002:aa7:dd81:: with SMTP id g1mr9273111edv.274.1622884709858;
        Sat, 05 Jun 2021 02:18:29 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:9baf:51f:dba1:e228])
        by smtp.gmail.com with ESMTPSA id r4sm3777630ejd.105.2021.06.05.02.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Jun 2021 02:18:29 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <5009954210af20796d1cf88ca630d19ec12e2132.1622132690.git.pabeni@redhat.com>
 <e21808b1-36c0-62fe-e9b2-25020573f4c7@tessares.net>
Subject: Re: [PATCH mptcp-net] mptcp: wake-up readers only for in sequence
 data.
Message-ID: <e78ce85a-9a65-c1d1-df01-2f3c455942b8@tessares.net>
Date: Sat, 5 Jun 2021 11:18:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e21808b1-36c0-62fe-e9b2-25020573f4c7@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Paolo, Mat,

On 04/06/2021 21:58, Matthieu Baerts wrote:
> Hi Paolo, Mat,
> 
> On 27/05/2021 18:27, Paolo Abeni wrote:
>> Currently we relay on the subflow->data_avail field,
>> which is subject to races:
>>
>> 	ssk1
>> 		skb len = 500 DSS(seq=1, len=1000, off=0)
>> 		# data_avail == MPTCP_SUBFLOW_DATA_AVAIL
>>
>> 	ssk2
>> 		skb len = 500 DSS(seq = 501, len=1000)
>> 		# data_avail == MPTCP_SUBFLOW_DATA_AVAIL
>>
>> 	ssk1
>> 		skb len = 500 DSS(seq = 1, len=1000, off =500)
>> 		# still data_avail == MPTCP_SUBFLOW_DATA_AVAIL,
>> 		# as the skb is covered by a pre-existing map,
>> 		# which was in-sequence at reception time.
>>
>> Instead we can explicitly check if some has been received in-sequence,
>> propagating the info from __mptcp_move_skbs_from_subflow().
>>
>> Additionally and the 'ONCE' annotation to the 'data_avail' memory
>> access, as msk will read it outside the subflow socket lock.
>>
>> Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> Thank you for the patch and the review!
> 
> Just applied in our tree:
> 
> - 508f97cb7d94: mptcp: wake-up readers only for in sequence data
> - Results: 119541ecd3c9..02c88cfc4215
> 
> Builds and tests are now in progress:
> 
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210604T195755
> https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210604T195755

I have some issues with this patch. Please see:

  https://github.com/multipath-tcp/mptcp_net-next/issues/201

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
