Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC3C2BE05F
	for <mptcp@lists.linux.dev>; Wed, 10 Jun 2026 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105078; cv=pass; b=VRhXC/OzUzyU9jxly2BRHPYvhHdHM+/Q6w5j/0JvGzeZdOuDACruVYUm0WPKQFoFL5OEM0C95yh0u2xjJTe4Yc6IlKzyIN/J3gU/GUDMm9pZTYUbTGac6B/8LYG5zMFwfAthz3420Px6R8+LUSAsjiirVHb1YLebkQzOBCsXTYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105078; c=relaxed/simple;
	bh=vZc62OXMB/PyJ1ihTzxGwzq368queakHOIYSVizdXOs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZRCCcCbKKhfeqOXwx7iuC8E6GfXCayM5WhX8qYWwrSuuDEj+TwQIOjXOq6jofnWoLf7QkPu/MVl08I3iGoQnOodZfB/xY4xQtBnc7FfaWCUjLTvg3AtxOMW9GIXKSAq3jWMrUBv4QIpgu4qhmnVNamVJuMrk/MW7s4JrXs2CGJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=OMJy0bq4 reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="OMJy0bq4"
ARC-Seal: i=1; a=rsa-sha256; t=1781105072; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kDaySlGiW4kajpAHp2dbPZHTMNhPUXHbnmXTV7J2bhK/QGWdceQz77Oe9s9vJOx5e5+CTC8vEVUdIeDnO4uw2fEIs+L2VxA1hfornofxua8i/XdfyD6TpOvSuiEHpuK4Xv2uWbjBzaRkB7EG51SvEUXcM3jxAUsCCPzNuN+Tk4M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781105072; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vZc62OXMB/PyJ1ihTzxGwzq368queakHOIYSVizdXOs=; 
	b=ZR3ztYGTqjbQSX34p6VEAE2nM3+Z2+m9/hMbacYxCFme/TGo/Pzl9Zpi0heM4UhDE1zCcbC1BFpgvQextbsXfN3LD5kE+z2uubKTis0fgwiAF29GM/D1g328tW5Eo8PWerWk1LEMrQ3GXieceKMxu6cPSJP4w5Tm5EiRCP9nCAM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781105072;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=vZc62OXMB/PyJ1ihTzxGwzq368queakHOIYSVizdXOs=;
	b=OMJy0bq4aRy2O500kdBANcOQMdMfDl9PUIUCJTHDV4o0+D4UpoMeK5Gs0bueVMIu
	mprz9uhlUSYwAbtwmQil4/rgJaCHfW1SvyRBai/zdSjYpvA4B79OarXB3gJwp+wM9ir
	WYJdoUxELVOedTZLsQ8nb2NpMaBH9T99TUFAccXk=
Received: by mx.zohomail.com with SMTPS id 1781105068744580.0180904907343;
	Wed, 10 Jun 2026 08:24:28 -0700 (PDT)
Message-ID: <73704f7d4212390acdb20332d73d456cf75690d2.camel@mpiricsoftware.com>
Subject: Re: [PATCH net v2] mptcp: pm: fix memory leak from
 alloc-during-teardown race
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com,
 janak@mpiric.us,  kalpan.jani@mpiricsoftware.com, shardulsb08@gmail.com
Date: Wed, 10 Jun 2026 20:54:20 +0530
In-Reply-To: <6046a321-9f73-46d9-93d5-5bfe62416cc8@kernel.org>
References: <20260523212930.2957096-1-shardul.b@mpiricsoftware.com>
	 <6046a321-9f73-46d9-93d5-5bfe62416cc8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ZohoMailClient: External

Hi Matt,

Thanks for the review.

On Wed, 2026-05-27 at 15:02 +1000, Matthieu Baerts wrote:
>=20
> I guess you also validated the v2 against your reproducer, right?
>=20

To be precise, I don't have a standalone reproducer: the syz-repro C
program does not trigger it. What reproduces it is our BRF-based MPTCP
harness (syz-manager), which hits the unpatched leak within minutes at
~0.3 reports/minute. Against that, v2 removed the original ANNOUNCE-
versus-final-close leak.



> I'm asking, because sashiko thinks there is still a way to hit the
> issue
> if the userspace does a shutdown() (mptcp_disconnect()):
>=20
> https://sashiko.dev/#/patchset/20260523212930.2957096-1-shardul.b@mpirics=
oftware.com
>=20

sashiko is right, and I had not fuzzed v2 long enough to see it before.
A longer run on the v2 kernel has now surfaced the residual for the
first time: the 64-byte mptcp_pm_addr_entry from the ANNOUNCE append,
on the disconnect/reuse path it describes. mptcp_pm_data_reset() clears
the fence without pm.lock after the lists are emptied, and the reused
msk can be re-selected to a non-userspace path manager, whose teardown
does not free userspace_pm_local_addr_list, so the late append is
orphaned.

So v2 closes the common final-close path but is incomplete on
disconnect/reuse.

For v3 I will free userspace_pm_local_addr_list unconditionally in
mptcp_pm_destroy() (dropping the mptcp_pm_is_userspace() guard), so an
entry added after the fence is cleared is reclaimed at the next
teardown regardless of the path manager in effect; the fence stays for
the final-close path. I will send v3 shortly and, in parallel, run it
on the same harness for 10-15 hours and report the result on the v3
thread.

The other sashiko note (id exhaustion: once all 255 ids are in use,
find_next_zero_bit returns 256 and truncates to the reserved id 0) is
real but pre-existing and separate from this race. I will leave it out
of this fix and look at it separately.

Thanks,
Shardul
