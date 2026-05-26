Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC933DFC6F
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794116; cv=pass; b=Tv+5SDSdhGDsTzrf64uMCqu51oJ+PMJUdrGdLNXgLPkWUr9TxgEJPz9LIc58hpwa6f0xCwamEoIBU3OfcmzLIPKPyxbw3IXAlCjvEBku7PCGgk97dH1L76BmSl+k8EwmiTkCchSUqHhT2Eg1TvHDagBPxmxLksB8GL1U8mnB2Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794116; c=relaxed/simple;
	bh=4OEowCxZjgRQJvD7ztodIVmrjwDgRLm0mD8SvXOfo+c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=A+vtqbNKG7kBGwgvbODXwc1qPdRxics2Tld3bSwYl9G6CcgMSSAZ4rsmkgbogOg2dYFRNn4Vvq+3tjqYPX3oxERdnISQvGES/6Y3u6De7ojUr0KYZu77S/M8HVSZODM1RZq3sSAOfYbJysLoP75ud0VFjPSn2sotVMXpyY19Ilk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=hZsYB5Ef reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="hZsYB5Ef"
ARC-Seal: i=1; a=rsa-sha256; t=1779794109; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kKMxz+J2CBWw9zUWXmZ9q5XwQsFmhkcRanIJpew6ZvrQ0IA9sJVVltWwd7Cc5r0a3XpCT2bQ6oQqFvMpCFoqiOjS9whSd1zdqyZswKXqE181JOYGs8Oack8NWsz1iVihltU7xLSZJ5CvM+BJAkP2LSJ+JzcR5HILEF2+z8Qa3Xc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779794109; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GrYT3NfTONuiSI1glKiotrCkeC43bUvEm4/+d3LQr8I=; 
	b=ikymcwOeyMS2c2xnFxvNFBvdkie0X7gm8FsB8gHc+/OA/Sle1grd0XVTLhu8lkk7iLVqqLCJZN0TxKFdsFcGoiCZ0sWp9acgSHE3G4munOIaC3XOzIEo74gfbhz1510T8lJIDMM+MaAtLL1S72KTErWmxk8A1SPUpch1ZzfWnlw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779794109;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=GrYT3NfTONuiSI1glKiotrCkeC43bUvEm4/+d3LQr8I=;
	b=hZsYB5EfJeQ1KQ715eHnodpSn249nC/SydyKsev3/50adrG27hA/+CkBoVM6M/yd
	BC8Wf5S5u6gNgxGuzEvs8fyAEpcqYT08zAVgCrwvKTkor5/2qCuzdRQ1o/tNmqU9xob
	TPWVpXGIqO1UXxU2MWJMdFD65FIlEYA3ETKCK564=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1779794107441424.822234632192; Tue, 26 May 2026 04:15:07 -0700 (PDT)
Date: Tue, 26 May 2026 16:45:07 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "mptcp" <mptcp@lists.linux.dev>, "martineau" <martineau@kernel.org>,
	"pabeni" <pabeni@redhat.com>, "janak" <janak@mpiric.us>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"kalpanjani009" <kalpanjani009@gmail.com>,
	"shardulsb08" <shardulsb08@gmail.com>
Message-ID: <19e63fedc1e.19d76b97534353.4482082124048801251@mpiricsoftware.com>
In-Reply-To: <07bf06c0-20dd-4e31-960a-b79f6fffcecc@kernel.org>
References: <20260525121911.2410171-1-kalpan.jani@mpiricsoftware.com> <07bf06c0-20dd-4e31-960a-b79f6fffcecc@kernel.org>
Subject: Re: [PATCH net] mptcp: pm: don't WARN on re-announced addr in
 kernel PM
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

Thank you for the review.

On 26/05/2026 ..:.., Matthieu Baerts wrote:
>> The WARN assumes the kernel PM can never reselect an address that is
>> still in msk->pm.anno_list. That is not true: [...]
>
> From what I understand, it means that if a "signal" MPTCP endpoint is
> removed the echo got received, the in-kernel PM will continue
> retransmitting the ADD_ADDR. That doesn't seem correct. I didn't check
> in the code, but I thought that the retransmit timer was at least
> stopped, but maybe the entry was not removed from the list?

You are right to expect the teardown. I checked the code, and it is not
uniform across the two removal paths:

- For a non-zero id endpoint, mptcp_nl_remove_subflow_and_signal_addr()
  -> mptcp_pm_remove_anno_addr() -> mptcp_remove_anno_list_by_saddr()
  -> mptcp_pm_del_add_timer(.., false): the timer is stopped and the
  anno_list entry is unlinked and freed. This path is fine.

- For the id 0 endpoint, mptcp_nl_remove_id_zero_address() does NOT
  call that teardown. It only queues a RM_ADDR and marks the id as
  available again; the pending anno_list entry and its armed timer are
  left alive.

So a stale entry can only survive on the id 0 removal path. When that
endpoint is re-added, the kernel PM reselects id 0, reaches
mptcp_pm_alloc_anno_list() a second time, finds the stale entry and
hits the WARN. That is the actual bug here.

> Does it also mean that if an ADD_ADDR echo is never received, the entry
> is never removed, even after having reached the max retransmissions?

Yes. In mptcp_pm_add_timer(), once retrans_times reaches
ADD_ADDR_RETRANS_MAX the timer stops re-arming (timeout = 0), but the
anno_list entry itself is not freed there; it stays on the list until
the endpoint is removed.

>> This is a benign transient state, so drop the WARN. [...]
>
> If I understand correctly, the transient state is not benign, and the
> WARN should not be dropped.

Agreed. I will drop this patch. The WARN is a valid assertion; the fix
should keep it and instead make the id 0 removal path tear down the
pending ADD_ADDR, mirroring the non-zero id path (drop the anno_list
entry, stop its timer, and decrement add_addr_signaled if it had been
announced). I will send that as v2.

> Also, it would be nice to add a new test to validate that. Here, it
> might be easier with a packetdrill test [1] [...]

Will do. I will add a packetdrill test that sends an ADD_ADDR, withholds
the echo, and then removes and re-adds the endpoint, based on
add_addr4_server.pkt.

Cheers,
Kalpan Jani




From: Matthieu Baerts <matttbe@kernel.org>
To: "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>, <mptcp@lists.linux.dev>
Cc: <martineau@kernel.org>, <pabeni@redhat.com>, <janak@mpiric.us>, <shardul.b@mpiricsoftware.com>, <kalpanjani009@gmail.com>, <shardulsb08@gmail.com>
Date: Tue, 26 May 2026 14:09:26 +0530
Subject: Re: [PATCH] mptcp: pm: don't WARN on re-announced addr in kernel PM

 > Hi Kalpan,
 > 
 > On 25/05/2026 22:19, Kalpan Jani wrote:
 > > syzkaller hit the WARN_ON_ONCE() in mptcp_pm_alloc_anno_list() with
 > > the in-kernel path manager, reached via
 > > mptcp_pm_create_subflow_or_signal_addr().
 > > 
 > > The WARN assumes the kernel PM can never reselect an address that is
 > > still in msk->pm.anno_list. That is not true: when an endpoint is
 > > removed and re-added while a previously sent ADD_ADDR is still
 > > awaiting its echo, the endpoint id becomes available again in
 > > id_avail_bitmap, but the matching anno_list entry (with its
 > > retransmit timer) is still alive. The in-progress guard in
 > > mptcp_pm_create_subflow_or_signal_addr() only checks
 > > BIT(MPTCP_ADD_ADDR_SIGNAL), which is already cleared once the option
 > > has been transmitted, so the address gets reselected and reaches
 > > mptcp_pm_alloc_anno_list() a second time.
 > 
 > From what I understand, it means that if a "signal" MPTCP endpoint is
 > removed the echo got received, the in-kernel PM will continue
 > retransmitting the ADD_ADDR. That doesn't seem correct. I didn't check
 > in the code, but I thought that the retransmit timer was at least
 > stopped, but maybe the entry was not removed from the list?
 > 
 > Does it also mean that if an ADD_ADDR echo is never received, the entry
 > is never removed, even after having reached the max retransmissions?
 > > This is a benign transient state, so drop the WARN. For the kernel
 > > PM, just bail out: the ADD_ADDR is already in flight, and the PM will
 > > be rescheduled once it completes (or once the stale entry's timer
 > > expires).
 > 
 > If I understand correctly, the transient state is not benign, and the
 > WARN should not be dropped.
 > 
 > 
 > Also, it would be nice to add a new test to validate that. Here, it
 > might be easier with a packetdrill test [1]: start with one sending an
 > ADD_ADDR [2], but don't send the echo, and instead, remove and re-add
 > the endpoint.
 > 
 > [1] https://github.com/multipath-tcp/packetdrill
 > [2]
 > https://github.com/multipath-tcp/packetdrill/blob/mptcp-net-next/gtests/net/mptcp/add_addr/add_addr4_server.pkt
 > 
 > Cheers,
 > Matt
 > -- 
 > Sponsored by the NGI0 Core fund.
 > 
 > 

