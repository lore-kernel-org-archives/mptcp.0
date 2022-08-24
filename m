Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969FF6711
	for <mptcp@lists.linux.dev>; Wed, 24 Aug 2022 16:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661360281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BbwYxccnRs7pAdVJLaPq1j+wVVAA09aqY7eo2GhrB0E=;
	b=eDG1jdWTyX2y/ZgPOScKJ/+NXOjB4yhjg2TtPSuo2cu398FG+SmwbUhI734EYd1nKk+a1Q
	L5gMzrDSm0M3KWefDFDPl8nU9qOvYoFJxh8h1+AjcZNvezA3tknc3jQo10By9kN00ASGp0
	vQEvDEGv4xVxNNGOXSr1h97uBca+zgw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-575-5pukFtK9PGSiYx9gMUFGlg-1; Wed, 24 Aug 2022 12:58:00 -0400
X-MC-Unique: 5pukFtK9PGSiYx9gMUFGlg-1
Received: by mail-qt1-f198.google.com with SMTP id d20-20020a05622a05d400b00344997f0537so12227161qtb.0
        for <mptcp@lists.linux.dev>; Wed, 24 Aug 2022 09:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=BbwYxccnRs7pAdVJLaPq1j+wVVAA09aqY7eo2GhrB0E=;
        b=rhVZ/hmCShCQwAquNUS+DRu35urrlnFuKEQzkGo32Ufwlyr/UaamC2+BtUg1quakeE
         Qw4blJdcTnyCjKDI9TmkiR092/xJcz/ioe4TRJzbdIey8c0NVjIeoP1Qopb01JwNjn3V
         BhQaoKuY8GndnpAJykz11gAZ2NYUicT1nNQAMmhENmj/TV41FnxpWWKov6pXg3MzzyLu
         Ha3Iycrm+wZzZe8NATatpK2QOVQCyowwvpfvd7YRjrRE8RZW8ymGGmpVcWvbipw7Hl1L
         H2oMjU0OskA0dB/rkaqCYubTJw1JvhTEOMCBFgclxsUqNSyJVrx3TXupuOUPecdOY7yF
         OfyQ==
X-Gm-Message-State: ACgBeo36zg/t11SKGBGqdwz5/dIefFnIvuQ4ckSpTF2oqFrnoPyaHXaD
	as3sOTHrSP16ZhELQZuoKT8mtz4eBzJgcsKOB4Gb2jUX+tlyJxoP5G+CA+uGYmHhk3pBmBZsgkj
	R8ItuuB0K0o/KtkbRawVVBzOo2Ikin4zJVa8tENiGjUrdGHNavFWJ4y2R8+EKmc3c
X-Received: by 2002:a05:620a:198e:b0:6bb:7651:fc7 with SMTP id bm14-20020a05620a198e00b006bb76510fc7mr137089qkb.376.1661360279891;
        Wed, 24 Aug 2022 09:57:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4QUbGJNWf0JQ5JGyJO3mD8kJ8KGN0oF2nUwd4qCeVjZjisp7fMEAbDREzYrKiiJkYNdhS9kA==
X-Received: by 2002:a05:620a:198e:b0:6bb:7651:fc7 with SMTP id bm14-20020a05620a198e00b006bb76510fc7mr137067qkb.376.1661360279485;
        Wed, 24 Aug 2022 09:57:59 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-176.dyn.eolo.it. [146.241.97.176])
        by smtp.gmail.com with ESMTPSA id w20-20020a05620a0e9400b006bbda80595asm12708924qkm.5.2022.08.24.09.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 09:57:58 -0700 (PDT)
Message-ID: <838c0079ceb8efc44377b8eb6baf2e62f76bc407.camel@redhat.com>
Subject: Re: [mptcp]  d24141fe7b:
 WARNING:at_mm/page_counter.c:#page_counter_cancel
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Date: Wed, 24 Aug 2022 18:57:56 +0200
In-Reply-To: <YtVhyGSsv1CWvPz4@xsang-OptiPlex-9020>
References: <YtVhyGSsv1CWvPz4@xsang-OptiPlex-9020>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello,

Since the rx path refactor is showing to be quite problematic, I'm
looking back the original issue, to see if that is really needed.

On Mon, 2022-07-18 at 21:36 +0800, kernel test robot wrote:
> [  240.473094][T14986] ------------[ cut here ]------------
> [  240.478507][T14986] page_counter underflow: -4294828518 nr_pages=4294967290
> [  240.485500][T14986] WARNING: CPU: 2 PID: 14986 at mm/page_counter.c:56 page_counter_cancel+0x96/0xc0
> [  240.494671][T14986] Modules linked in: mptcp_diag inet_diag nft_tproxy nf_tproxy_ipv6 nf_tproxy_ipv4 nft_socket nf_socket_ipv4 nf_socket_ipv6 nf_tabl
> es nfnetlink openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c sd_mo
> d t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 i915 sg hp_wmi ipmi_devintf intel_rapl_msr intel_rapl_common ipmi_msghandler x86_pkg_temp_thermal i
> ntel_powerclamp coretemp crct10dif_pclmul crc32_pclmul intel_gtt sparse_keymap crc32c_intel platform_profile drm_buddy ghash_clmulni_intel mei_wdt rfkil
> l wmi_bmof drm_display_helper rapl ttm ahci drm_kms_helper libahci intel_cstate syscopyarea intel_uncore mei_me sysfillrect serio_raw libata i2c_i801 me
> i sysimgblt i2c_smbus fb_sys_fops intel_pch_thermal wmi video intel_pmc_core tpm_infineon acpi_pad fuse ip_tables
> [  240.570849][T14986] CPU: 2 PID: 14986 Comm: mptcp_connect Tainted: G S                5.19.0-rc4-00739-gd24141fe7b48 #1
> [  240.581637][T14986] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
> [  240.590600][T14986] RIP: 0010:page_counter_cancel+0x96/0xc0
> [  240.596179][T14986] Code: 00 00 00 45 31 c0 48 89 ef 5d 4c 89 c6 41 5c e9 40 fd ff ff 4c 89 e2 48 c7 c7 20 73 39 84 c6 05 d5 b1 52 04 01 e8 e7 95 f3
> 01 <0f> 0b eb a9 48 89 ef e8 1e 25 fc ff eb c3 66 66 2e 0f 1f 84 00 00
> [  240.615639][T14986] RSP: 0018:ffffc9000496f7c8 EFLAGS: 00010082
> [  240.621569][T14986] RAX: 0000000000000000 RBX: ffff88819c9c0120 RCX: 0000000000000000
> [  240.629404][T14986] RDX: 0000000000000027 RSI: 0000000000000004 RDI: fffff5200092deeb
> [  240.637239][T14986] RBP: ffff88819c9c0120 R08: 0000000000000001 R09: ffff888366527a2b
> [  240.645069][T14986] R10: ffffed106cca4f45 R11: 0000000000000001 R12: 00000000fffffffa
> [  240.652903][T14986] R13: ffff888366536118 R14: 00000000fffffffa R15: ffff88819c9c0000
> [  240.660738][T14986] FS:  00007f3786e72540(0000) GS:ffff888366500000(0000) knlGS:0000000000000000
> [  240.669529][T14986] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  240.675974][T14986] CR2: 00007f966b346000 CR3: 0000000168cea002 CR4: 00000000003706e0
> [  240.683807][T14986] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  240.691641][T14986] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  240.699468][T14986] Call Trace:
> [  240.702613][T14986]  <TASK>
> [  240.705413][T14986]  page_counter_uncharge+0x29/0x80
> [  240.710389][T14986]  drain_stock+0xd0/0x180
> [  240.714585][T14986]  refill_stock+0x278/0x580
> [  240.718951][T14986]  __sk_mem_reduce_allocated+0x222/0x5c0

The above basically means __sk_mem_reduce_allocated() is trying to
release/uncharge a negative amount of pages (-6)

> [  240.724443][T14986]  ? rwlock_bug+0xc0/0xc0
> [  240.729248][T14986]  __mptcp_update_rmem+0x235/0x2c0

After the mentioned/bisected commit:
d24141fe7b48d3572afb673ae350cf0e88caba6c ("mptcp: drop SK_RECLAIM_*
macros")
in __mptcp_update_rmem() -> mptcp_rmem_uncharge():

	/* see sk_mem_uncharge() for the rationale behind the following schema */
        if (unlikely(reclaimable >= PAGE_SIZE))
                __mptcp_rmem_reclaim(sk, reclaimable);

if can end-up calling __mptcp_rmem_reclaim() ->
__sk_mem_reduce_allocated() with a negative value if 'reclaimable' is
negative: 'PAGE_SIZE' is UL, 'reclaimable' is a signed integer, will be
implicitly casted to UL, and any negative value will match the
condition.

So 'reclaimable' is negative, which in turn means either 'msk-
>rmem_fwd_alloc' or 'msk->rmem_released' are negative before this call.

I can't see how any of them may become negative. Any help/second
opinion more then welcome.

> [  240.734228][T14986]  __mptcp_move_skbs+0x194/0x6c0

side note: this is quite unusual. __mptcp_move_skbs() could do any real
work only on very exceptional conditions.

> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>         sudo bin/lkp run generated-yaml-file
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.

Still no luck to reproduce it here...

/P

