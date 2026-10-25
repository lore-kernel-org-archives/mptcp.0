Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792956208;
	b=3NuP12dliwv7emyR2Todf181w8HgvRjgTIZch34JV82S3LWVy0CzCYKU+As7ZLqHGVmb
	 KaTwlJL0O6PXt73aNmw990vX79584DIJE1ABJ9guDn4amq8XPwISpGVm4MotF14CLN34a
	 Vku9ZZJm38EbFmhMcXMmXCg1oQddxuSShynusmJTr25apzcX8eM8EdBJpT+VYRWHnZZRr
	 LVDv1T068VJKr7TlowuusN4jadHMfJ9eaIrajXev/u5AVy81zIRuzrzWXKgLJ2Tdh2tqF
	 Pr4MwAjFl/wOxijfoiOn8NlLo7ltZlY+XC6YFJaLps9bMkPdPEgzbz6K3dBSCNnCkNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956208;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2pZiLiCs1EPClBtHaMUiY2+ncRDndtpDYb4X2uwrh0g=;
	b=accdD37jaYXzhA5DOhwi6cqbptvKFDjZFVDgVNJg/OEbKzAUoEk7jbIE6rdk06ZCFqG3
	 90KYf2imyOV6aCncVdkdWrXwlB5gJOVHxv996GzJWeOyl9uY0lJLnebqYdZQMoxBDGxrZ
	 EF5WeiuuaaTGTmPzYiDsJwW/XjhEVfZYifb07mWugL13ZX3Eu+qDHCkgSwNodm/MUTTLx
	 4vmkW75yIdc/YMh7iDLDuXclrdE92fEjo+XDHLGeJ4PIjr3fh9zYhOA/Q9QppdKL3ip9D
	 a9B+PJeBdGQPJtoSQ+8DmRPnp2PXdVfgUgHIL5Iad9DR5RsDKpFjHNZvr9BXSt0sENA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dM2xkd4m;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB284606A323
	for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 19:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB284606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dM2xkd4m
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-369f33df08eso1569558eec.0
        for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 12:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792956207; x=1793561007; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2pZiLiCs1EPClBtHaMUiY2+ncRDndtpDYb4X2uwrh0g=;
        b=dM2xkd4mPh74kzEkn2UYzj131kWQvi7BAlj5rXvjGsPKLyWiV5GYAK1lXAiir0NiOb
         694+VBAPcEvmtSfxTFnHOW5ndx1+emn1ADCIIwM0ZolRlqU5kgenYWFhh5PgQeFrXMNx
         ndDAien4xg7ALN8o81d559KFdPc9DQYf5lohtpDFdYnFLw98PxHDn7tFToMOn/UyuCTt
         XKGg7ZHe6DurqCpSFfqYwTNbJwA8DP++z8X0VvE7eq/8DrbIVReu8swOaGHIzX7p3RN5
         VvKRSDZMzLrxC22fSlJC5Ds1KGQaMwWvJArLsUG1oxtX2HdcvL1oKUOmSTbWgbMwBpX/
         GBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792956207; x=1793561007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2pZiLiCs1EPClBtHaMUiY2+ncRDndtpDYb4X2uwrh0g=;
        b=TE8FmaxWFVmFKJjsG3sJGx4fz+G2adN9TSqW90RL7gBBwQzjwiP8MtbyeqH5m7qc/S
         d49FNTNym/WudTKkyuFmIS4qQ60ne7XT5PfRv19yz7wrKanHA0FlgUe7gP9TeOGaMeMw
         z/9E/BO5d79ZOWRGaGG6dq26m1PdgMY1KzhT38EMtXVQFx1v8GxfKzgXsFtksbku6+Jz
         Vn9E0CESX+NC7A/PRtW4Bo+H8D2/JwCL2aSorOj/UjGNWoixBR+2UNbwq0QHL6wGv7id
         PciW9QeEXd2Dh3gXKA0FunobDwbatL4W72OMl4XUiX4+jnLXnrZ2TsW8Fed7aPoOtRhp
         CH0Q==
X-Gm-Message-State: AFq9FYK9Gij8gh5sGIhzYN3uvvmu1PkRdjK752VifHx51cAw96J9dJs9
	Eoeqf9l3zQ7+/vaBLKgoSsEYB0Cablsgvdh4jg0djqHT79D99GSbudzW
X-Gm-Gg: AYBFou2u8CjFpkQB5Ge7MfXVmK0MkyohTsJq1rwuUQQEGkIuTyDtN8yP5RDhEFlu4nO
	hCbiZjHwOm76KDSbX9sZXoyQ0fi/s9lVOmdkR3qvPSgvlM0uOI+syyoCtvcW6kRIRBaU5rtnWrd
	qapk4W0K1xF9ay5EI8iwXyKIpdKRejcxjBOqrZGMhPAfTtpLBJqnUQf85OocMCnzm9P1ryEnFef
	U1RZQNQJtRwGCxbXN2zTPx41zQJioM575IdHpituXJ8DFiGh+A5bRqNjvxKEnUTkp8rh9wD711N
	BaO9XUbT/Bwkj+nya/wlc35ziAqfrynbXEkjbK6Pvapbxmck9fL6yFramr/oDceTtNVKaPvBbg9
	YtHhmnYnldD6ypyeGYItNOi/R+J8cUehvNnNF6MRukPMX94tQijqRf7NnBCn5XZOhUdil+h8AkO
	3HrqcWdjSr0TlxdWHhaqrYVC8LB+nUGZ/GGnI+QRGBrT2LnZub6hMcwD3p4bAKwo00xokWEoLoK
	mxZKf7qw09zukarMb/DOhi+k1BdZ4GP+wgMZWlGta2XE1YnWZGJx6b29Glu
X-Received: by 2002:a05:693c:6391:20b0:369:f85c:787c with SMTP id 5a478bee46e88-369f85c79b0mr3355359eec.10.1792956205553;
        Sun, 25 Oct 2026 12:23:25 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8db7b23sm25251266eec.19.2026.10.25.12.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 12:23:25 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev,
	Matthieu Baerts <matttbe@kernel.org>,
	Janak Patel <janak@mpiric.us>,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next v4 0/4] mptcp: sched: penalise a slow subflow
Date: Sun, 25 Oct 2026 19:23:20 +0000
Message-ID: <20261025192320.1831707-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911-mptcp_penalise_send_v2-v4-0-820f2be4a8fe@mpiricsoftware.com>
References: <20260911-mptcp_penalise_send_v2-v4-0-820f2be4a8fe@mpiricsoftware.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shardul,

I tested v4 on top of the current export (77f43f9f7643). Patches 2 to 4
needed a small context fix in protocol.h, because of the new
close_event_done field.

Setup: two paths in netns, netem on both directions, one iperf3 MPTCP
connection for 20 s, upload and download, BBR and CUBIC, tcp_rmem max
6 MB and 32 MB. 9 path pairs, for example 400M/10ms + 15M/120ms,
40M/10ms + 2M/250ms with 5% loss, 40M/5ms + 30M/35ms with 17 ms jitter.
3 runs each, 10 runs for the three noisiest pairs.

I found no regression. Throughput is the same within noise in every
case. The 400M + 15M pair with CUBIC and 6 MB looked worse at first, but
it's bimodal (about 30 or 65-170 Mbit) with and without the series, and
10 runs each show no difference. There are two small changes, both with
CUBIC. The jitter pair gets 66 Mbit in all 10 runs without the series
and 64-65 in all 10 runs with it. Two 50M paths with 1% loss each go
from 10 to 9 Mbit, and that's where the halving fires the most, about
140 times over the 3 runs in each direction.

But it rarely fires. In most cases CwndPenalised stays at 0 or a few
while PenalCandidate counts hundreds or thousands. To see why, I added
two local counters, one after the cwnd-limited check on the fastest
subflow and one after the receive window check. Download, 6 MB, 2 runs:

                   candidate  fastest cwnd-limited  wnd ok  penalised
  starve  BBR        75 / 131         0 / 2         0 / 0     0 / 0
  hol     BBR         27 / 46         0 / 4         0 / 0     0 / 0
  starve  CUBIC     147 / 251        87 / 241       0 / 0     0 / 0
  jitter  CUBIC   1668 / 1524     1668 / 1524      26 / 24   16 / 13

With BBR the fastest subflow is almost never cwnd-limited, since BBR
paces and keeps cwnd around 2x BDP. So the series does nearly nothing
for BBR. With a 6 MB buffer the receive window check from patch 3 stops
most of the rest. With 32 MB it fires more often, but still only on a
small share of the candidates (starve with BBR: 341 cwnd-limited out of
1541, 1 penalised).

Is that what you expect for BBR? If the cwnd-limited check is only
there to know that the fastest path is saturated, something that also
works for a pacing CC might be needed.

Selftests: mptcp_connect passes. simult_flows failed test 9 ("unbalanced
bwidth with opposed, unbalanced delay") in 1 out of 8 runs with the
series, but also in 2 out of 8 without it on the same base, so that's
not from your patches.

Tested-by: Abdul Wasey <w453y.me@gmail.com>

Thanks,
Abdul Wasey
