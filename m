Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572BD2C8B
	for <mptcp@lists.linux.dev>; Wed, 20 Oct 2021 11:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1634729610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hMArPdlHSVeUChRKYxRIHPEucDinifl6uu57kp/lM8Q=;
	b=i33K84+WJhWCx0u8SYjyGA+lptMBnniOY9BzjqogSNI5ftjfekFiBmTHrsDFU/QH5nakL4
	jF/mEXFnUKkdS9s8KTy1aBDvM0df007Psd8TkeJnX0eCqLdGoB0SxIiKhJBLIjQDA1y85E
	vP3f3cR+vZhTQs9i1d8k5vwV3LSJiE0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-Lexp_9zHNpCgxXIjBA4y5g-1; Wed, 20 Oct 2021 07:33:29 -0400
X-MC-Unique: Lexp_9zHNpCgxXIjBA4y5g-1
Received: by mail-yb1-f199.google.com with SMTP id x16-20020a25b910000000b005b6b7f2f91cso30437842ybj.1
        for <mptcp@lists.linux.dev>; Wed, 20 Oct 2021 04:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hMArPdlHSVeUChRKYxRIHPEucDinifl6uu57kp/lM8Q=;
        b=1zTYPDYq0+FxSfo0jHOrfk2CzXFfBK9PndRe6oF4Indu1+Z80Ctghdj4xAToxjay6C
         BaTeOfqfwM3Rja0+j2bqDEKZvIzHhLAXLB6JaJ299FMMNDVq4bTYckM97DT63GNelUfy
         cj4+aUS6rLLG+k7Umh7tR48U+C8IKkALa9fZZdty0uimOJWn3YSlbeU5L+6Kt6D0rV0e
         T7VmLJrsUeKJlDxMqPTgl2l3HWiJSngCoqFf6O6uyDXrqZKbdiPUWDHNzXySwYjzMAcy
         Y6PJsnHI8t5H55QwIS4u5G7NUtgDKmR9pvtfDyhWcnMGenlrwYFAoGV2/cj96Vd2jsRn
         AVVA==
X-Gm-Message-State: AOAM533MDmbp7ORWb9ClV8LmjxGxfbyJ5Fezx1MInVd3A0tiE2agXVhx
	uwB4GLYi6cKU0xarqMYYST5tXHxTnQ7yPjyHqDfr6epsfsjAlpveyKOOsq8J+cJs4QJ523Dx/MO
	oBBuZKFaH11K2a6vG54Q6R8a9jEE8vqg=
X-Received: by 2002:a25:bdce:: with SMTP id g14mr41855272ybk.352.1634729608478;
        Wed, 20 Oct 2021 04:33:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhqOt0qdAhLN7G1tTqMfsbkMO5+O/IawtyLL4wsSdMSawTrKFxBbvcp0dJBMMOhNkJr6RZydQAJezqic1p6V0=
X-Received: by 2002:a25:bdce:: with SMTP id g14mr41855249ybk.352.1634729608273;
 Wed, 20 Oct 2021 04:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1634531093.git.geliang.tang@suse.com> <2e9a15d32cd39483dd1e18174d6c73b33e0566b5.1634531093.git.geliang.tang@suse.com>
 <7e1c37e5-a636-68f1-aaa-329f951b2c55@linux.intel.com> <CA+WQbwt4dk5vQyoPgxv7=ctsaNetcbt855Md+SL6juFZcLUPgA@mail.gmail.com>
 <YW6BzNwiyR9i8KSQ@dcaratti.users.ipa.redhat.com> <f61714c1-09cb-e4a0-f78c-5294bcaea890@tessares.net>
In-Reply-To: <f61714c1-09cb-e4a0-f78c-5294bcaea890@tessares.net>
From: Davide Caratti <dcaratti@redhat.com>
Date: Wed, 20 Oct 2021 13:33:17 +0200
Message-ID: <CAKa-r6vQo+=tQDMRkyG2xczR8wMYPufRD4LU7Xj9+xbP2zVWGw@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v7 8/8] DO-NOT-MERGE: mptcp: mp_fail test
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Geliang Tang <geliangtang@gmail.com>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>, Geliang Tang <geliang.tang@suse.com>, 
	MPTCP Upstream <mptcp@lists.linux.dev>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dcaratti@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

hi,

On Wed, Oct 20, 2021 at 12:40 PM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
[...]

> >
> > I had a script that used TC flower and gact + pedit + csum actions to flip the 'PSH'
> > bit in the TCP header, I promised myself to change it to corrupt the DSS option.

FTR, that script was:

# convert PSH,ACK into ACK
# tc filter add dev vetha egress protocol ip prio 1000 flower ip_proto
tcp tcp_flags 0x18/0xff action pedit ex munge tcp flags set 0x10 pipe
csum tcp reclassify
# convert ACK into PSH,ACK, 1 each 10 packets
# tc filter add dev vetha egress protocol ip prio 1001 flower ip_proto
tcp tcp_flags 0x10/0xff action pass random determ pipe 10 pedit ex
munge tcp flags add 0x8 pipe csum tcp

> > The problem with this approach is, we can't assume that the DSS option has a fixed
> > offset from the IP header. So, the test might start corrupting other options that
> > are not MPTCP.
>
> If we corrupt any data in TCP Options or data and update the TCP
> Checksum, that's enough to corrupt the DSS. For example, we could flip
> the last bit of the TCP payload (if tcp.len > 0). Would it be possible
> to do this by adapting your script?

it's easier if it's the first bit, then...

> For mptcp.org, I told someone to use netfilterqueue + scapy. He had some
> issues but also shared a working version:
>
> https://github.com/multipath-tcp/mptcp/issues/420#issuecomment-825771587
>
> I guess we cannot depend on Python and Scapy for selftests. I don't know
> if we can also easily depend on eBPF either :)

'bpf' kselftests (and also tc-testing)  already depend on eBPF, so for
linux this is a no-problem.

> And using simple solutions like "tc netem corrupt" will be detectable by
> TCP csum.

this can be easily workarounded using the 'csum' TC action after the
netem dequeue.

> So maybe your way is better if we can corrupt anything, e.g. using a
> fixed offset like 120 or the last bit (if it is not an ACK). WDYT?

I redirected this question to some friends working on eBPF, and they
told me it's doable and cool at the same time :)
There is an eBPF program that parses the "timestamp" option [1], we
can change it easily to corrupt the DSS and recompute the TCP checksum
like in Matteo's RHD article.

WDYT?
--
davide

[1] https://github.com/xdp-project/bpf-examples/blob/master/pping/pping_kern.c#L83

