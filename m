Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABD62C80
	for <mptcp@lists.linux.dev>; Thu, 20 Jan 2022 15:04:17 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id z22so29785832edd.12
        for <mptcp@lists.linux.dev>; Thu, 20 Jan 2022 07:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=rSrFV+4HczU9+KfY/ugY5wJUj64Hye8IaOwLV8ZGMeA=;
        b=ymKEcE5uJUpDkTVV+LFr0MYJWbrPMxtrvNZRzTz8fxH7VTncVWpXVyqp40LlLmjwq6
         0+GeQOKSZMg2ndlDUC7xps9+zQaHQl8hwnZETj4fVDMR/BxQ5MOuR9hUuZKBv4bJIi1w
         FkGsO3i+YWfcsxHIn/9yFK8rEbJ+CyHXuRyAQqzN3ownbd4jOrAGqSjaMQezHn1b1pLE
         aU4YIx+fzZNcU1R9b9syRfNrVmTfkLQ+0LVlkiVV8pEUNhJJdNYn+UYiuTGBvoTPfI3K
         g98X1uaBEsETvb93m9hWSs9WS6bYmYwBxytZzSLPQdVDZLm58PPUo/WHOm8jL0fU29Dc
         LEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rSrFV+4HczU9+KfY/ugY5wJUj64Hye8IaOwLV8ZGMeA=;
        b=1J6qS73tdHw1Bc7FppNSgiSE8FHwYAgQVBFD8G8cc3n+fooMLXG/apSZqsm3CYcZaL
         FKBySxPMazclapTHxrjBLilX6bqE1Z/7EKBDzvxu3AIBfdnY1/5zmHOjLMD4NwGDFEG+
         Hb0eQLeAf0qZlBXocXP5p1SickuDiBxXpvkDa66etJcvJ+XpgWR2N/0xD/WzBFCaconw
         0Slhr4NWwsine/A7Ct/Vls4Pfzv36CuY65Zry/d4ovREHlwpG8Ga70NEp7qECQThpOzl
         n4zdIkZZ6RtbeS+xO6+tIX0VUqaKuq1pNCNVCc/5scgkfn/zXunC9DG8JRAwMfOQUTml
         uiKg==
X-Gm-Message-State: AOAM531Ax9b2udIRkK7/vQsxne4IbqDGcAnjXLgfKFSlrDqBwMBDdS8E
	haUbCwMxwD5gGViPDKUVNtAoG3eL7MZZFZUm
X-Google-Smtp-Source: ABdhPJzair8hstgMWI/FHx5gqwB8CLdsOb+nqv3BeU/smY40O6GPegWEUH0nK+gYKcPbdmQtoDCZiw==
X-Received: by 2002:aa7:d504:: with SMTP id y4mr422067edq.404.1642691056101;
        Thu, 20 Jan 2022 07:04:16 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id cr8sm1412757edb.47.2022.01.20.07.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 07:04:15 -0800 (PST)
Message-ID: <ea4337cf-0bff-5669-7fb4-738b03f0c1e9@tessares.net>
Date: Thu, 20 Jan 2022 16:04:15 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next v2 00/10] set flags and selftests
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1642320655.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1642320655.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat, Paolo,

On 16/01/2022 09:17, Geliang Tang wrote:
> v2:
>  - use a mask of changed flags as Mat suggested.
>  - squash patch 8 and patch 9 in v1 into one.
> 
> Geliang Tang (10):
>   mptcp: set fullmesh flag in pm_netlink
>   selftests: mptcp: set fullmesh flag in pm_nl_ctl
>   selftests: mptcp: add fullmesh setting tests
>   mptcp: allow to use port and non-signal in set_flags
>   selftests: mptcp: add the port argument for set_flags
>   selftests: mptcp: add backup with port testcase
>   selftests: mptcp: add ip mptcp wrappers
>   selftests: mptcp: add wrapper for showing addrs
>   selftests: mptcp: add wrapper for setting flags
>   selftests: mptcp: set ip_mptcp in command line

Thank you for the patches and the reviews!

Just applied in our tree (feat. for net-next) with Mat's RvB and Paolo's
ACK (on the 3 first ones only) tags and without typos spot by
checkpatch.pl --codespell (see patchwork for the details)

- b705fd7215b9: mptcp: set fullmesh flag in pm_netlink
- 6217aef203f5: selftests: mptcp: set fullmesh flag in pm_nl_ctl
- 158dc9a65aa3: selftests: mptcp: add fullmesh setting tests
- 3e710d18759c: mptcp: allow to use port and non-signal in set_flags
- 61fe48d3c297: selftests: mptcp: add the port argument for set_flags
- bd2761b79d26: selftests: mptcp: add backup with port testcase
- 58972f3b5692: selftests: mptcp: add ip mptcp wrappers
- cc944025a862: selftests: mptcp: add wrapper for showing addrs
- 94b163441224: selftests: mptcp: add wrapper for setting flags
- 5627a6a4a066: selftests: mptcp: set ip_mptcp in command line
- Results: fbaefb5453f9..88ed28f981da

I also applied the 3 squash-to patches linked to this series:

- f6b3ae3ddda1: "squashed" in "selftests: mptcp: set fullmesh flag in
pm_nl_ctl"
- 797bceadf4f5: "squashed" in "selftests: mptcp: add backup with port
testcase"
- 955e2784c04e: conflict in t/selftests-mptcp-add-wrapper-for-setting-flags
- dbd4ae0f794f: "squashed" in "selftests: mptcp: add wrapper for setting
flags"
- Results: 88ed28f981da..e974a42412b3

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220120T150402
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
