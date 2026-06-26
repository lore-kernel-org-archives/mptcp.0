Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4B83EB0F0
	for <mptcp@lists.linux.dev>; Fri, 26 Jun 2026 10:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782468852; cv=pass; b=WKLYaLLtKO+dAu0en1AJqfSyIbljD3KzxdGW2RSDexS+AjCTQ+FA0urOVjddxCmVaU4lW+fpzybMzNS5MGum7Yoja6aey0+jB03xFu0BATqBVuLrmh8/eTZNSipYqgmQeNcsxrujdlDMojVamb4las24EgjFvWwi32dpAKr66pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782468852; c=relaxed/simple;
	bh=IQP0LFoTP6K4gmvfZqsokHvWFKa92O/KlQb8GjZ3EXM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=AMAPXaDC/Hl7AcIYE/ocfiKSIfgNU/CqmCNZH5L0GCTY6fGww/8tT3YoBAzOskHAoXRbQEyKn3QZjV0aluYSeMwfgpcWr6H8AFC9yfDhBKgshiq0+0IFgjW4tLAsPM4LiI6s2SW0IVLGzyVr0RnF/Oc4ncY8bEv0CCnUlvOPXeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=r1rA1CoA reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="r1rA1CoA"
ARC-Seal: i=1; a=rsa-sha256; t=1782468844; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jsJktvBP8mVVaXBTXyC/9Awcj4RJ7iya6IF9vrDQjo/kGyyaswdi/SyzogaIDj9dL3Y0inUBHh3IyPMw6w/EFhqKcFsAefSC1TmL2syfOVP+Ls9OBmky0sEmn0n3iXwtw14FlLaG1GOh/hhI6FJjW3LN4HNgjjgZ6zv9vdWVWqo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782468844; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=daHkSbQ3DX15VyrvudquOlnQgZpnEYTFznwlH34zAzc=; 
	b=L0n+PGF0BGc4hPojM9vlvnaERAIOqbZJus7wtNoIOCsvoLWqGdk9/zhwuZdtzM0fbY1ea/uuclwHmiNos5D8Fj7zWmwojLgXQGDrwYRlFKAXIybl9eQD2nmMSHopFaDiXFhUXQ/G+s/sPer2U9r4FqDG2YTITHguEQ0nfngJb6c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782468844;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=daHkSbQ3DX15VyrvudquOlnQgZpnEYTFznwlH34zAzc=;
	b=r1rA1CoAFHQDzcXBPlMgwp7kmzTwZzCvmPU0xGmwRFgRSwwZRo23jI8XULwG/mwF
	L0qBYOWXI/e8d8MPcvRU9rMDt5XXxbR21yZ5TQW3bgHO7Q1pAL7v4/pmRWfXSOYKK9M
	G32liT7yLGJQV6/KcwV51P0eP53BVaeBRLhhCvCc=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1782468844234244.24368075364157; Fri, 26 Jun 2026 03:14:04 -0700 (PDT)
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1782468843031791.3688594686001; Fri, 26 Jun 2026 03:14:03 -0700 (PDT)
Date: Fri, 26 Jun 2026 15:44:03 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "mptcp" <mptcp@lists.linux.dev>, "martineau" <martineau@kernel.org>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"janak" <janak@mpiric.us>, "kalpanjani009" <kalpanjani009@gmail.com>,
	"shardulsb08" <shardulsb08@gmail.com>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"syzkaller" <syzkaller@googlegroups.com>
Message-ID: <19f036c1604.59cdbbcc785569.3427362170288763554@mpiricsoftware.com>
In-Reply-To: <9245c477-8609-4263-82dc-49d8af1aec2c@kernel.org>
References: <20260601083010.924938-1-kalpan.jani@mpiricsoftware.com>
 <f644447b-87de-4e9f-81de-d43811f39a4e@kernel.org> <9245c477-8609-4263-82dc-49d8af1aec2c@kernel.org>
Subject: Re: [PATCH net v4] mptcp: fix stale skb->sk reference on subflow
 close
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Matt,

Thanks for the feedback.

You're right. I had used Claude Opus 4.8 to assist with analyzing the issue and refining the commit message, while I implemented, reviewed, and tested the patch myself. I've updated the next revision accordingly by adding the appropriate `Assisted-by:` trailer and removing the standard MPTCP selftest note from the commit message.

I'll send v5 shortly with these updates.

Cheers,
Kalpan Jani


From: Matthieu Baerts <matttbe@kernel.org>
To: "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>, <mptcp@lists.linux.dev>
Cc: <martineau@kernel.org>, <shardul.b@mpiricsoftware.com>, <janak@mpiric.us>, <kalpanjani009@gmail.com>, <shardulsb08@gmail.com>, "Paolo Abeni"<pabeni@redhat.com>, "syzkaller"<syzkaller@googlegroups.com>
Date: Fri, 26 Jun 2026 14:44:15 +0530
Subject: Re: [PATCH net v4] mptcp: fix stale skb->sk reference on subflow close

 > Hi Kalpan,
 > 
 > On 25/06/2026 10:39, Matthieu Baerts wrote:
 > > Hi Kalpan,
 > > 
 > > On 01/06/2026 10:30, Kalpan Jani wrote:
 > >> The backlog list is updated by mptcp_data_ready() under
 > >> mptcp_data_lock(). The cleanup of backlog references to a closing
 > >> subflow, however, was performed in mptcp_close_ssk(), before
 > >> __mptcp_close_ssk() acquires the ssk lock, and while holding neither
 > >> the ssk lock nor mptcp_data_lock().
 > 
 > (...)
 > 
 > >> Tested with the MPTCP kernel selftests on the patched kernel:
 > >> - tools/testing/selftests/net/mptcp/mptcp_join.sh: all tests pass
 > >> - tools/testing/selftests/net/mptcp/mptcp_connect.sh: 68/68 pass
 > > 
 > > Note that you don't need to specify this: for MPTCP patches, we assume
 > > all kernel selftests and packetdrill tests are passing. If you did other
 > > "unusual" tests -- e.g. running many times a reproducer mentioned in the
 > > issue -- then that's interesting to add that in the commit message.
 > 
 > I just got a note saying that's the kind of phrase an LLM agent adds. If
 > that's correct, please don't forget to add the required "Assisted-by:"
 > trailer when you rely on an LLM agent. (That would also avoid me
 > possible issues when upstreaming these patches.) Also, in this case, it
 > is often useful for the reviewers to explain what you as a human did. See:
 > 
 >   https://docs.kernel.org/process/generated-content.html
 >   https://docs.kernel.org/process/coding-assistants.html
 > 
 > Cheers,
 > Matt
 > -- 
 > Sponsored by the NGI0 Core fund.
 > 
 > 


