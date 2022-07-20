Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F9E7475
	for <mptcp@lists.linux.dev>; Wed, 20 Jul 2022 21:07:22 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id w12so25263828edd.13
        for <mptcp@lists.linux.dev>; Wed, 20 Jul 2022 14:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=byTbtkG1y6OqroUAnBTrNkp18/ma/1+IPsFHlJmcMok=;
        b=UJr7UCCrYaAcw4tj7FOBkIJTy7ytyPYcGBELrQ7DAX+eLVD9o8RqlguWlzbD+2uhb4
         aSsRtUPoKe2I+Sm5nLQCC75KZJ0mQJeI+TzA5DS54z+vkaoD4Cu7EmvXV/0pzcMwLIfZ
         OmC4P99nSzFcDutguHXBOcctUKWW8pyCwpDrE9PF6zy7bNfVwI/31lfxseignMeHeD53
         mgHpPo4TOXX4eZBW/b/nRG9Ml0rBV/LtNqIMq366F1YNxva5aBBo3JHlvm/iJOMtvHDl
         mWZBQrpmqDyg9qBst/jsikcE9zhUe6OgzkHsT/D7/xl0DWhBsijOJrQLO3q8UcP76M8n
         tqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=byTbtkG1y6OqroUAnBTrNkp18/ma/1+IPsFHlJmcMok=;
        b=rK0ZQS0b8phKt/m1oHLUssXE1RtniazIgV2DfFINgO5hTswYAP4JPfD4rTKYWyCT/5
         fV3/iZYpuzzdYfg4VxXTorqn/GIHiilMePmUSleIuLzZCdF/ky46hbiBpAMkz+juPIaA
         X1uD+reVYRIwcuI1sKevYIL7uFmEJaqme0qT671NVBe1JncVsqsfny4WjhCH8C4s4xQ/
         zf0V0hm2QgfrVmqzIr3V8wkOr0RevcbBhVO48lMxexIvzPTp1hM4X7Lw8YbsWxVXcODh
         me804xHzKua47y/qA6QG6Jaqiy0W8ReQNuCUDVIp/J+KVATDDJyZ7VwYMBkCES8+3OgF
         Stww==
X-Gm-Message-State: AJIora9aM0DKQjqR0FDCyT0ppLV/Z9OHSasBtI5pXEklSRmJeGVSQCJv
	P/G/cUrC9XkzYWbAhO7mly8Rfw==
X-Google-Smtp-Source: AGRyM1s4PmaXPckFNTuL69Vx1dCUqW2uODb6FrgYlStKw52yJz+cnuZNgfIWIcYplqYsY6NunxSYUQ==
X-Received: by 2002:a05:6402:22b5:b0:43a:8e9f:f495 with SMTP id cx21-20020a05640222b500b0043a8e9ff495mr52353981edb.324.1658351241038;
        Wed, 20 Jul 2022 14:07:21 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:5c89:ec72:45e4:3bcb? ([2a02:578:8593:1200:5c89:ec72:45e4:3bcb])
        by smtp.gmail.com with ESMTPSA id b27-20020a17090630db00b0072af843c794sm79461ejb.43.2022.07.20.14.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 14:07:20 -0700 (PDT)
Message-ID: <d1f761a8-2f89-c0d9-0d61-103d7c78c0ac@tessares.net>
Date: Wed, 20 Jul 2022 23:07:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [PATCH mptcp-net] mptcp: move subflow cleanup in
 mptcp_destroy_common()
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: phind.uet@gmail.com, mptcp@lists.linux.dev
References: <bcfa7cfc41ada0c8811794cb3c45cdeb1b34f303.1657883173.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <bcfa7cfc41ada0c8811794cb3c45cdeb1b34f303.1657883173.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 15/07/2022 13:10, Paolo Abeni wrote:
> If the mptcp socket creation fails due to a CGROUP_INET_SOCK_CREATE
> eBPF program, the MPTCP protocol ends-up leaking all the subflows:
> the related cleanup happens in __mptcp_destroy_sock() that is not
> invoked in such code path.
> 
> Address the issue moving the subflow sockets cleanup in the
> mptcp_destroy_common() helper, which is invoked in every msk cleanup
> path.
> 
> Additionally get rid of the intermediate list_splice_init step, which
> is an unneeded relic from the past.
> 
> The issue is present since before the reported root cause commit, but
> any attempt to backport the fix before that hash will require a complete
> rewrite.
Thank you for the patch and the review!

Now in our tree (fixes for -net):

New patches for t/upstream-net:
- 4b5a18b64fca: mptcp: move subflow cleanup in mptcp_destroy_common()
- Results: b0fec3f01957..7023536b34d1 (export-net)

New patches for t/upstream:
- 4b5a18b64fca: mptcp: move subflow cleanup in mptcp_destroy_common()
- Results: fc8aa8591c3b..04e53d6af29a (export)


Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220720T210003
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220720T210003

> ---
> The tags are provisional, waiting for Nguyen feedback/preferences.
> 
> Sending out early to trigger the CI.
> 
> This will need likely some staging period.
> 
> "mptcp: add mptcp_for_each_subflow_safe helper" needs to be rebased
> on top of this (we can replace another list_for_each_safe instance)

Done! Thanks for the note!

- de34e44fab5e: conflict in
t/mptcp-add-mptcp_for_each_subflow_safe-helper (+ use the new helper in
mptcp_destroy_common())

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
