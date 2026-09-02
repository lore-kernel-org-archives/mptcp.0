Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF8939902D
	for <mptcp@lists.linux.dev>; Wed,  2 Sep 2026 06:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331710; cv=pass; b=aa/b2p2uCNBrM1T+jfb4XUocAGBX0MZ8H2lJsybbGcjJHs3tQgKeTOSO/jNooH5qQ0+zsG09hdseQ+wNuTOXzNOBBpLkcsWWrQMvj/99E9NYGnxiFyFiEN/k3DT3Jr0IHmpDuL2uoYnC2GVUCLrQjqGmHIt343zWzhFj5aSEHjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331710; c=relaxed/simple;
	bh=cdeFoFYy1OoM8VP2+d7S1FB2dEDDNTiGo7cZqr/QI7M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=tsq8m5YExiKSFSIXuUSk73KeXroerbGKgyv2uZ2ln5Zd5QKiyJh8umUOV8Oh0WN7gyBPEgef1GZEfMz39eTxlAHiz4pZ58wULgaCPoFzIgpNzhR4tfjui9CaJ3cQER3D3J17mh19XNvp4afHP8d7KrTPgxxIv8r5/5uWrHjOlzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=jpJm7RvK reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="jpJm7RvK"
ARC-Seal: i=1; a=rsa-sha256; t=1788331703; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SE6jQJSVOM/8neD9c841HQxyClm8+MFq7446Xe2My2unmeqAnM6971bCxeraFR2X2OC2IxLUX4KfAPotFPlBho6GVYLi1tSjsptwOK8QIJaO7XG5OBhggyr9Es1UxPpC3hzJoOVV+/Uq2/S9Y+KMAyBxPf7IJS5BTlTGuIlh+e8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788331703; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=A3MI3nokX7AeSe0lTaNPs+1ovIFeBrCUZxPg9d59o5o=; 
	b=URofL49h+fXcezqrjuleGrhUy8I37Zs4Irhf5/jdHeSuqiHJFM6G1ADbbc1UCbI/54RtFH/Q163MjJtrUWcHb5OYplF4s1pGb4uwLAYz0hDaiaIh33vNfQosCla3Nvc4TdjK/P6+bSy0GOD4GgwIX+OdxT4IfobwaXyLybaUmms=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788331703;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=A3MI3nokX7AeSe0lTaNPs+1ovIFeBrCUZxPg9d59o5o=;
	b=jpJm7RvKTysOEm6dQKCzy/fEBEyVl7dtrMDC58tBPd1azGD7pZYtDI/R8Lx5UXUV
	EY8oR5oNoKVTsRUV8lOxSygNEY8MKY5G+a2WoGa8GSqnA5UBRKzcAuOp4on3pR8PO+H
	66B4jpdSwLvt7KXc3z5ALR3N0mqsrYpnRf8Z2pcM=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1788331703446762.702138809904; Tue, 1 Sep 2026 23:48:23 -0700 (PDT)
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1788331701134163.10910533526487; Tue, 1 Sep 2026 23:48:21 -0700 (PDT)
Date: Wed, 02 Sep 2026 12:18:21 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "mptcp" <mptcp@lists.linux.dev>, "martineau" <martineau@kernel.org>,
	"pabeni" <pabeni@redhat.com>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"janak" <janak@mpiric.us>, "kalpanjani009" <kalpanjani009@gmail.com>
Message-ID: <1a060e0334d.16e6f547114597.2162647064543858742@mpiricsoftware.com>
In-Reply-To: <22e3fc57-a6e7-4a72-a6c1-1d6b3bc39f3d@kernel.org>
References: <20260827041058.2833707-1-kalpan.jani@mpiricsoftware.com> <f0fabe59-0a2b-4df9-983d-446eab20104c@kernel.org> <1a05b681764.2d9af68b190464.2524660538561791488@mpiricsoftware.com> <22e3fc57-a6e7-4a72-a6c1-1d6b3bc39f3d@kernel.org>
Subject: Re: [PATCH net-next v2] mptcp: normalize seq numbers reported in
 mptcp_info
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

You were right, thanks for pushing back on that. I added msk_state to the same debug print and reran mptcp_join.sh - every single instance of msk->first going NULL shows msk_state=7 (TCP_CLOSE), no exceptions across several hundred hits. So it really is only happening as part of the whole msk already being torn down, like you said, not during a live connection.

I'll rework v3 to read idsn/iasn straight off msk->first instead of adding the two new fields, per your suggestion.

Cheers,
Kalpan Jani


From: Matthieu Baerts <matttbe@kernel.org>
To: "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>
Cc: "mptcp"<mptcp@lists.linux.dev>, "martineau"<martineau@kernel.org>, "pabeni"<pabeni@redhat.com>, "shardul.b"<shardul.b@mpiricsoftware.com>, "janak"<janak@mpiric.us>, "kalpanjani009"<kalpanjani009@gmail.com>
Date: Tue, 01 Sep 2026 11:25:08 +0530
Subject: Re: [PATCH net-next v2] mptcp: normalize seq numbers reported in mptcp_info

 > Hi Kalpan,
 > 
 > 01 Sept 2026 07:19:21 Kalpan Jani <kalpan.jani@mpiricsoftware.com>:
 > 
 > > Hey Matt,
 > >
 > > Thanks for the suggestion. I dug into msk->first before reworking it.
 > >
 > > Turns out it's only ever set once (either connect side or accept side) and never reassigned to a different subflow after that, so at least we don't have to worry about picking up idsn from the wrong one later.
 > >
 > > But it does go NULL independent of whether other subflows are still around, and it's not even a rare thing. I added a debug print in __mptcp_close_ssk() and ran mptcp_join.sh, and it happens constantly with other subflows still in the list. I couldn't find anywhere that write_seq/snd_una/ack_seq get reset in that case either, so reading idsn/iasn straight off msk->first in mptcp_diag_fill_info() would need a NULL check, otherwise it'd crash pretty often during normal multi-subflow use.
 > 
 > Thank you for having checked.
 > 
 > Is it not only set to NULL when the whole msk is being destroyed? So
 > yes, it could be set to NULL first while closing all the subflows, but is it
 > an issue at that stage? Maybe you will need to add an extra check to
 > avoid a crash, but (I didn't check) maybe there are already protections
 > in place and it cannot race.
 > 
 > (Note: I'm not on my laptop, I didn't verify this)
 > 
 > Cheers,
 > Matt
 > 


