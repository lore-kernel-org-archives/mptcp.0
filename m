Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685D12F28
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 12:36:36 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id a8so6865976ejc.8
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 04:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7K6Y8rwcAWOJTRrX7si8X3VWDVnKmunx659ZgWd0xgs=;
        b=aodJuzKemrpOg+SHLl2apNSUNejgVNKjDfMWvmLvrtFP2ZbtCqfaTOesB8LzhxAARK
         EeO7M3bniH/7VAfcRs/Ky5/NXHpK5gMXRJX2Bn8Ta6lXH2zmUkV5+2uqqYi+G81Ym2z5
         BH5uRplUlKUMiPympxZ5dzfJVhuvTLxbeFveOaex8VqXEaeRLGm6oa+gHkggj3eKxT0k
         6riRomdbfZeNSf0zkXKglyLPaTf2W1zOlchFqHr4e/azR+esGgWXRiGxs/lNN+KiU9E4
         jSnMcFvX34MguxazQM8gT8hJZUR3YwbS6s2vv2wbZCChIMZMOKSZmrp+5YLqVINi6koq
         HunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7K6Y8rwcAWOJTRrX7si8X3VWDVnKmunx659ZgWd0xgs=;
        b=0r/PcHB0VMjZ0z4bGDRxVKrGgYzzhQnigrJeTrQCVPmdLrM4ImEDqXzxOhEJvRQTVm
         RZEZuznNN5Er3eY4HwbN9ek9v/TqD8mSnNs1d6tNvin69NDg2BUMi4zdTgT8HYKSme6+
         vrnFJeaaT6hnhuB8AO0pJQ6gPYY2c1bFIsceNiDuIoO9/P4qX2asSasG/bs1qwxNuU34
         JXIO3cjCH6oMG563GZ3DaQJzGdz3IJ8ro0sryyo10HKvbocKnmoe52h0z5QnIQzYyGwA
         Xg3NoBD+ZZ9QECyILOYytWLnPBBqnCdLIj19El/nr04kYtW9Lj72kIZpDF5vcB1O5OgZ
         Hl6A==
X-Gm-Message-State: AOAM530MBfSS3kL/Ovciu4cw7uq/RKOGU5g2Vyjjz2O12xCpPa7rok1N
	qRfkjTlRrjw/P080n1ICDfT51w==
X-Google-Smtp-Source: ABdhPJwnjjNupNiPQ1E96w+ANcfA346LRPx35OZb24sz7ktY+e9OwYPOWNHVukwu+QQLm17jCrpUug==
X-Received: by 2002:a17:907:6088:: with SMTP id ht8mr1772434ejc.528.1644410194535;
        Wed, 09 Feb 2022 04:36:34 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:42a6:e0be:778a:86e8? ([2a02:578:8593:1200:42a6:e0be:778a:86e8])
        by smtp.gmail.com with ESMTPSA id k15sm5046140eji.64.2022.02.09.04.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 04:36:34 -0800 (PST)
Message-ID: <fd43654f-12eb-9830-0360-acb42c9d5a55@tessares.net>
Date: Wed, 9 Feb 2022 13:36:33 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next v5 5/5] selftests: mptcp: add mp_fail testcases
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: Davide Caratti <dcaratti@redhat.com>
References: <cover.1644402973.git.geliang.tang@suse.com>
 <c1dd2b5c0105f42b9fb12447011d3830c057ac57.1644402973.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <c1dd2b5c0105f42b9fb12447011d3830c057ac57.1644402973.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 09/02/2022 11:43, Geliang Tang wrote:
> Added the test cases for MP_FAIL, the multiple subflows test for the MP_RST
> case and the single subflow one for the infinite mapping case.

The tests are passing on the public CI, that's good!

But the output is less good:

# Created /tmp/tmp.crkOA4p7hr (size 1024 KB) containing data sent by client
# Created /tmp/tmp.jFbZEAnYZa (size 1024 KB) containing data sent by server
# file received by server has inverted byte at 195585
# 100 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] -
ack[ ok ]
#                                          sum[ ok ] - csum  [ ok ]
#                                          ftx[ ok ] - failrx[ ok ]
#                                          rtx[ ok ] - rstrx [ ok ]
#                                          itx[ ok ] - infirx[ ok ]
# Created /tmp/tmp.crkOA4p7hr (size 1024 KB) containing data sent by client
# Created /tmp/tmp.jFbZEAnYZa (size 1024 KB) containing data sent by server
# [ FAIL ] file received by client does not match (in, out):
# -rw------- 1 root root 1048604 Feb  9 11:37 /tmp/tmp.jFbZEAnYZa
# Trailing bytes are:
# MPTCP_TEST_FILE_END_MARKER
# -rw------- 1 root root 1048606 Feb  9 11:37 /tmp/tmp.ghV0iWPhu5
# Trailing bytes are:
# MPTCP_TEST_FILE_END_MARKER
# file received by server has inverted byte at 169
# 101 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] -
ack[ ok ]
#                                          sum[ ok ] - csum  [ ok ]
#                                          ftx[ ok ] - failrx[ ok ]
#                                          rtx[ ok ] - rstrx [ ok ]
#                                          itx[ ok ] - infirx[ ok ]

Did you not do a modification earlier not to print "file received by
client does not match" error while it is "normal" for the moment to have
that in this case?

Even if it is temporarily, would it not be better to add a variable
"corrupted_data", set to 0 in the 'init()' side but set to 1 for this
test? When it happens, we expect to have a mismatch, we can print a
message if it was (with a ref to a GitHub ticket?) and mark the test as
failed if not. WDYT?

(also, because from a TCP point of view, the packet is still OK, we
could also not drop the data but that's another discussion)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
