Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6252E17C1
	for <mptcp@lists.linux.dev>; Mon,  3 Oct 2022 11:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664796400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UbvjxVfCxWUrArF0ml4tn5iECe4zNgfriHNLRC1/LvE=;
	b=ViqvcIxsCCeisAGp/FxVbq6gvYQHegtl9gn+lda2HJs4Ff5IBmvWVrJlDhLQKhfSTaOFI/
	E52sIt6a3tDky72XygOHNxbu8xzHE7GAbyYGAOXn98d3/cc8T7Tiz2IXxnhP9fP5EgBBds
	kFns2SHfdOSrZNML/2wQpFbCZd7qAOQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-12-g2d-xKXKPHeLbI7elhOzfQ-1; Mon, 03 Oct 2022 07:26:36 -0400
X-MC-Unique: g2d-xKXKPHeLbI7elhOzfQ-1
Received: by mail-qk1-f199.google.com with SMTP id k2-20020a05620a414200b006ceec443c8bso8892122qko.14
        for <mptcp@lists.linux.dev>; Mon, 03 Oct 2022 04:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=UbvjxVfCxWUrArF0ml4tn5iECe4zNgfriHNLRC1/LvE=;
        b=ZrUeBPA6QFlvYVA+IqBKO4/A8fJqOmR+q28VjSwjJhHYOM303EknKMwtd62BFqas5g
         zhfJN6RoIbS5fzJ4OTGl/ihw1BIAGhcSxDG9ktm+m8BzPFC0BHl/A78gcRTbYGS365KL
         h95Aew92ggtoTi+/erILL2c7SGn9B6AS5FpiYvmK0O/46QxjWUw8ErhzZiMKYGcQMMKu
         O2g5XCg+3qzru9/6H+e3P03VA/4scXldR0PBk6hhTh+BQ5PHCRG1YcEVg0fD8kMS+yGa
         1SbWfnod1oUdeGzpNKTmosruyLVDIlgYGyRmbd0rdbRGGJPs3fHmIJpHzQt+4SVcdjln
         3w6w==
X-Gm-Message-State: ACrzQf2y6/fDUVq1V1QSMFYRHVTDQViLIwA8X40Yz5BHFsFKwtBQ53Ts
	Wru+2MMnxOkXojWyWjj59B0TSDoEWzpXG29raY0N4l7GC6O7r0vh0BNny8gQlO5jAa+I86xNep0
	CoPUoCTNrpJLT8p0=
X-Received: by 2002:ac8:7fd0:0:b0:35b:b0a4:a6e9 with SMTP id b16-20020ac87fd0000000b0035bb0a4a6e9mr15633384qtk.397.1664796395812;
        Mon, 03 Oct 2022 04:26:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6lvURzShq/1pM2EA8v9zREEDT5GkYJsdoe/pSD/KF8gJ0zimeA9ksaK8Kaisd28ehn9/FwzA==
X-Received: by 2002:ac8:7fd0:0:b0:35b:b0a4:a6e9 with SMTP id b16-20020ac87fd0000000b0035bb0a4a6e9mr15633372qtk.397.1664796395498;
        Mon, 03 Oct 2022 04:26:35 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-71.dyn.eolo.it. [146.241.97.71])
        by smtp.gmail.com with ESMTPSA id s15-20020ae9f70f000000b006cf43968db6sm10551386qkg.76.2022.10.03.04.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 04:26:34 -0700 (PDT)
Message-ID: <6369983d0849eddf7c0637fe5f7e5444485f0df3.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v12 1/7] mptcp: introduce MSG_FASTOPEN
 flag.
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Date: Mon, 03 Oct 2022 13:26:32 +0200
In-Reply-To: <ef992d926ce674558f1123bdde363d556f45b457.camel@redhat.com>
References: <20220927225341.14165-1-dmytro@shytyi.net>
	 <20220927225341.14165-2-dmytro@shytyi.net>
	 <c074b37149bbad50ece1b0f0b6e380106b5a0e38.camel@redhat.com>
	 <44a60bfa-720e-1984-d0c7-dce080a14d4e@shytyi.net>
	 <ef992d926ce674558f1123bdde363d556f45b457.camel@redhat.com>
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
Content-Transfer-Encoding: 8bit

On Mon, 2022-10-03 at 10:02 +0200, Paolo Abeni wrote:
> Hello,
> 
> On Sat, 2022-10-01 at 05:08 +0200, Dmytro Shytyi wrote:
> > I'm getting the next stack trace [1] when following this approach, yet 
> > it needs uarg to be filled, not NULL.
> > 
> > After Matthieu suggestion, I tried to implement the .connect in mptcp, 
> > but I'm getting errors like "ENOBUFF" or "EINPROGRESS".
> > 
> > Finally I decided to continue with "mptcp_stream_connect()" function in v13.
> 
> The reported error is not clear at all to me. It's better to clarify it
> before moving to the next version, or steps could (likelly, will) be in
> the wrong direction.
> 
> > [1] Code starting with the faulting instruction
> > ===========================================
> > [   27.736069] RSP: 0018:ffffc90000adfce0 EFLAGS: 00010246
> > [   27.737115] RAX: 0000000000000000 RBX: ffff888003894440 RCX: 
> > 0000000000000000
> > [   27.738560] RDX: 0000000000000010 RSI: ffffc90000adfe80 RDI: 
> > ffff888027ce8000
> > [   27.739883] RBP: 0000000000000000 R08: 0000000000000001 R09: 
> > ffff888015710cf0
> > [   27.741286] R10: 0000000000000001 R11: ffff888003ca78c8 R12: 
> > 00000000ffffff96
> > [   27.742718] R13: ffffc90000adfdb0 R14: ffffc90000adfe80 R15: 
> > ffff888027ce8000
> > [   27.744135] FS:  00007f7cc983a740(0000) GS:ffff88803da00000(0000) 
> > knlGS:0000000000000000
> > [   27.745612] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   27.746788] CR2: ffffffffffffffd6 CR3: 000000001d180006 CR4: 
> > 0000000000370ef0
> > [   27.748125] Call Trace:
> > [   27.748655]  <TASK>
> > [   27.749086] __inet_stream_connect (net/ipv4/af_inet.c:663)
> > [   27.750093] ? sk_reset_timer (net/core/sock.c:3341)
> > [   27.750803] ? tcp_connect (net/ipv4/tcp_output.c:3882)
> > [   27.751590] ? kmem_cache_alloc_trace (mm/slub.c:3286)
> > [   27.752492] tcp_sendmsg_fastopen (net/ipv4/tcp.c:1198)
> > [   27.753347] mptcp_sendmsg (net/mptcp/protocol.c:1710)
> > [   27.754047] sock_sendmsg_nosec (net/socket.c:714)
> > [   27.754831] __sys_sendto (net/socket.c:2117)
> > [   27.755539] ? handle_mm_fault (mm/memory.c:5151)
> > [   27.756311] ? do_user_addr_fault (arch/x86/mm/fault.c:1426)
> > [   27.757175] __x64_sys_sendto (net/socket.c:2129 net/socket.c:2125 
> > net/socket.c:2125)
> > [   27.758029] do_syscall_64 (arch/x86/entry/common.c:50 
> > arch/x86/entry/common.c:80)
> > [   27.758739] entry_SYSCALL_64_after_hwframe 
> > (arch/x86/entry/entry_64.S:120)
> > [   27.759719] RIP: 0033:0x7f7cc99484e6
> > [ 27.760458] Code: 69 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 
> > 1f 00 41 89 ca 64 8b 04 25 18 00 00 00 85 c0c
> 
> This backtrace is incomplete/lacks the oopsing address, so is unclear
> what really went wrong. Please report the full backtrace.
> 
> Important: please include the code you used for this test. No need to
> post the full old patches here, you can e.g. share an URL to your git
> tree/branch.
> 
> The main point is that this backtrace does not look compatible with the
> code suggested previously.

I discussed this with Mat(ttbe) on IRC. It looks like the main problem
is that mptcp don't implement the struct proto/sk->sk_prot->connect,
and the defer_connect is not triggering such path as subflow the socket
is not in SS_UNCONNECTED state on defer connect.

The correct solution would be re-factor the mptcp connect code/hooking
to re-use the inet_stream_connect() infrastructure. I'll try to cook
the relevant patch - not strictily fastclose related - asap, so that
you can rebase this series on top of them. 

Cheers,

Paolo

