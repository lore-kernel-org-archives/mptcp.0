Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ABA382
	for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 18:58:50 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so1791299wmb.0
        for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 10:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+fX4JhVNBGqllUBlj7wOnzcpcE8JAayc8pqg4L2rbWc=;
        b=0/k2GS1ZiBP+Csjz4vA1zxnBZRl4eA7RfGsmSbGf/qBQcmsOPaoB2MOQibdjtPsyAh
         ipZc4quMHzf52j+MghhMk/f6HcKIqwo7sK5USj85TTmQMPYT7DSdAYARmo+nyzXZZGCc
         gSBPQMo56zYfEiwbeFWSQ1/4uUij18m4lFTNo4BlMQJ55hjHqXVMGbAaWgvYt3Z1TYkV
         d4se8s7JD7aSHK9yFyORjw53g+4Z0qLXC+xQoc0nFb9TIHE2zmvVNi4GO40TvYeiJLqf
         dLilhxFgss4fd5n4ZJ8b0NcNqkkBIYbTnH/8OiUxH7nk+JuIZ4l7eK+kBwNKn+44OFVq
         3ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fX4JhVNBGqllUBlj7wOnzcpcE8JAayc8pqg4L2rbWc=;
        b=CKV+HmGWNzuCFRVAvieV8uEP9sdHAfzadL4lptMdqtVdFoakg7lzm8uWnQrYmfmgqt
         5QAMNAUYLA1OVWSVQnLt33E7Q65e1nHA6Sc2HxwgC/mgSCNZNW5AFk89y8f3I4C8yWkt
         miXi4eN1D3h0zeVgwOumpQoznt3SDaE9gZcU5eX3IznZlxe0sEL4zEKIePk2YN8FBOdI
         Vdwsr34fhjwYLbxyVo9gXrs0omvhSGxyF4kgxaufQ3msoPVVjUcmTgCEjFLI+bexP+XT
         jlHjSdVgYH1u9awwDm9qDiyQWrFFPBUvwTsbtvnjK2tieoxIF+LydZZuXWGCbC2QQs3Y
         Sj5w==
X-Gm-Message-State: ACrzQf23vDkRW0ENcsoqXh3VMEGdwc8Y6+rG3f54q0W4yUhhI1eMzRJi
	rXCTEPP13uKTX25VRdxI4dIuhExEPM+Ao6gA2EY=
X-Google-Smtp-Source: AMsMyM7JKHttNWv+ho8S5X9NgXIHVJ+IZ9pxnCfCBUWQdVMzwgFLI0M3tmAiceCRf+LzKTgKFxToWg==
X-Received: by 2002:a05:600c:26d1:b0:3cf:7b67:f490 with SMTP id 17-20020a05600c26d100b003cf7b67f490mr36512244wmv.164.1668106728454;
        Thu, 10 Nov 2022 10:58:48 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:a69e:b302:f965:8831? ([2a02:578:8593:1200:a69e:b302:f965:8831])
        by smtp.gmail.com with ESMTPSA id q10-20020a7bce8a000000b003c6bd12ac27sm359867wmj.37.2022.11.10.10.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 10:58:47 -0800 (PST)
Message-ID: <2cfbb067-b36a-a9a8-efad-7cf9a438e901@tessares.net>
Date: Thu, 10 Nov 2022 19:58:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [RFC PATCH mptcp-next v15 0/5] mptcp: Fast Open Mechanism
Content-Language: en-GB
To: Dmytro Shytyi <dmytro@shytyi.net>, Paolo Abeni <pabeni@redhat.com>
References: <20221106152411.655-1-dmytro@shytyi.net>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221106152411.655-1-dmytro@shytyi.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dmytro, Paolo,

On 06/11/2022 16:24, Dmytro Shytyi wrote:
> These patches focus on the Initiator and partially on Listener side.
> The next options in userspace are available:
> a) sendto(..., ..., ..., MSG_FASTOPEN, ..., ...);
> b) setsockopt(..., SOL_TCP, TCP_FASTOPEN, ..., ...);
> 
> These patches implement Appendix-B of RFC8684 (MPTFO).
> 
> We would like to credit Paulo Abeni, Mat Martineau, Matthieu Baerts and
> Benjamin Hesmans for advices and ideas that improved these patches.
> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>

(...)

> Dmytro Shytyi (5):
>   mptcp: introduce MSG_FASTOPEN flag
>   mptcp: implement delayed seq generation for passive fastopen
>   mptcp: add subflow_v(4,6)_send_synack()
>   mptcp: add TCP_FASTOPEN sock option
>   selftests: mptcp: mptfo Initiator/Listener

Thank you for the patches, reviews and Squash-to patches!

These patches and the ones from Paolo are now in our tree (feat. for
net-next-next) with Paolo's ACK on patch 1/5 and 4/5 and the Co-Dev ones
automatically added on the 3 others.

Please note that I had two minor conflicts when applying Dmytro's
patches before the BPF series already in our tree + some issues reported
by checkpatch I didn't fix (yet).

I also had more complex conflicts in Paolo's first squash-to patch: it
is modifying both patches 2/5 and 3/5, I had to split it. Please check
everything is still OK after that.

New patches for t/upstream:
- c87fe09b3765: mptcp: introduce MSG_FASTOPEN flag
- b08f0e118b1e: mptcp: implement delayed seq generation for passive fastopen
- bbd23a7de970: mptcp: add subflow_v(4,6)_send_synack()
- a2e147cb3f0a: mptcp: add TCP_FASTOPEN sock option
- 132e3b9f088e: selftests: mptcp: mptfo Initiator/Listener
- Results: 5f9e0bf4aacf..120554402db6 (export)

Paolo's patches:

- 512d25e34a03: mptcp: track accurately the incoming MPC suboption type
- Results: 120554402db6..a6011a4a534a (export)

- c0cda5b7f267: "squashed" (with conflicts) in "mptcp: implement delayed
seq generation for passive fastopen" (part 1)
- 7f98dbf4215e: "Signed-off-by" + "Co-developed-by"
- 6d231fd79244: conflict in t/mptcp-add-subflow_v-4-6-_send_synack
- b2bb9c9570a0: "squashed" in "mptcp: add subflow_v(4,6)_send_synack()"
(part 2)
- 7d3cac0330e4: "Signed-off-by" + "Co-developed-by"
- Results: a6011a4a534a..7141982e8319 (export)

- 27f8b8024c74: "squashed" in "selftests: mptcp: mptfo Initiator/Listener"
- ebe619034d7f: "Signed-off-by" + "Co-developed-by"
- Results: 7141982e8319..dfaa717d485a (export)


Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221110T185015

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
