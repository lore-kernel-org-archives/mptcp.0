Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795676649;
	b=Gaz8TvK4UTvNLcpUSPROsrkW6cw1miHtS5y2X4tCQfE4TTYoOJGa1AQM1RaNILSlay39
	 z1F9jhk9GWrzdhBA5R6RVTNjzfQOLGoWR9teMpNsjunDsIyrLevgdGVO5dp/Ks+V4ubV/
	 FerwQC7nV3IKHakZUJ4k+lecFuBE1REhVZtuGVPq7lPqfVZErHJJupczJLoXWNxWTfOyr
	 qRW7JT1+jEmaJOWH7iTKoiAM+w92sO9XG0p3SM9sULa8MHa4AcSU2Lyozf/avPrPzh0aF
	 zXOeRQQ5fm8Yp7y0EEP20/yzJPANGtDrfUAiYVMo+2CeT3KLiqhCoJ0DojAKOGJLUqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795676649;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fwEkeMf8Y0fvwDc97iHg6+h4rQG/92Euq1PqUtnUeiI=;
	b=K0N0KYYctimr+ElZJYM+/BYEyIVS/n5cB9YoXFHwFVnGJuz8hGchOVTWcorZ84nikZrB
	 N5hs+DhUaJlEBcseP8/OT3QwQbufsyc+x6qvkKPy3hVuZSNrBgVyDM1dje/w8ndnbgovt
	 e3P6+jSbtNIPQEsDNZuUvUpL9G7k68r/SO+QVIYXJeN0KGl2oo059uzOY1PdAZeNLothl
	 WPq/C26UGoJQYglXJckvIUzOywG43yVn/VUGeCfV9b/LergPKH0rXPehnVZauVmhEc3Sh
	 Rr+Kldc4WPbOm6q5G+Sd+R+kcf159gY3y3uegSqYZxtUmysMwMrTsdWdcdwV3GD4x8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nspkiDM3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FC7606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 07:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nspkiDM3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BC91F000C0;
	Thu, 26 Nov 2026 07:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795676649;
	bh=fwEkeMf8Y0fvwDc97iHg6+h4rQG/92Euq1PqUtnUeiI=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=nspkiDM3h/V/gsjm0iKeW9udLsbGHs7AOyrmelL5s1JMRNF3FsF5vSrkF8x2C70Kb
	 ItVDaWdDvBY00x8zXkttYcIhnAmoe1LOLP+s703qr+NdPksG94KngQQzktCtcFNSYR
	 Iy2p1iXF1SYnmsOhZJFIPMXfPpjw7fSvJCkRRZjdd5tWznU2nfg4Y/PrGnmwJxtIfH
	 1/vxG6Q54aJP3UzrazXIc3H44L7jGeo9xJK4hbyJ/L6wcT8Cs0N1AvCiN9EvcKEdkG
	 o4E7xLEqBMDWlaYT8BZG/Ot1VGB61HEmFgqTji/U+tAut61tFtXioovKBJdFOLZSP+
	 D3h6MbQiVgAHA==
Message-ID: <50f4d21d44f291853805421d84e2a4ac3f25010f.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v3 18/50] mptcp: no fastclose reset from
 SYN_SENT subflows
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Date: Thu, 26 Nov 2026 15:04:03 +0800
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-18-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
	 <20261124-mptcp-cmason-fixes-v3-18-416c0920c73f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10build1 
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt,

On Tue, 2026-11-24 at 22:59 +0100, Matthieu Baerts (NGI0) wrote:
> mptcp_do_fastclose() sends a reset with an MP_FASTCLOSE on each subflow
> not in LISTEN or CLOSE, also on the ones in SYN_SENT, while TCP sends no
> reset in this state, see tcp_need_reset() used by tcp_disconnect(). On a
> disconnect in SYN_SENT, e.g. with connect(AF_UNSPEC), an MPTCP client
> then sends a reset with an MP_FASTCLOSE carrying an unknown key, 0. With
> TCP_FASTOPEN_CONNECT, this reset is even sent before any SYN.
> 
> Before the commit below, these resets were sent by tcp_disconnect(), so
> not in SYN_SENT. Skip them again in this state, as TCP does, but move
> the subflow to TCP_CLOSE at once, as tcp_disconnect() does: a SYN-ACK
> received before the end of the close cannot complete the connection, and
> a later one gets a reset from the stack.
> 
> This issue has been found by an AI code review agent, while reviewing
> "mptcp: clear DEFER_CONNECT on disconnect", and confirmed with a new
> Packetdrill test: a disconnect in SYN_SENT, then the SYN-ACK. Without
> this patch, a reset with MPTCP options was sent at the disconnect,
> before the one replying to the SYN-ACK:
> 
>   disconnect_in_syn_sent.pkt:16: error handling packet: live packet field ipv4_total_length: expected: 40 (0x28) vs actual: 56 (0x38)
> 
> Fixes: ae155060247b ("mptcp: fix duplicate reset on fastclose")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> v2: new, for an issue found by a review agent
> v3: move the subflow to TCP_CLOSE at once, not to complete the
>     connection with a SYN-ACK received in between (Clashiko)
> ---
>  net/mptcp/protocol.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 87f6da0f6cab..6c712f677220 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3321,6 +3321,12 @@ static void mptcp_do_fastclose(struct sock *sk)
>  
>  		subflow->send_fastclose = 1;
>  
> +		/* no reset in SYN_SENT, but a close at once, as TCP does */
> +		if (ssk->sk_state == TCP_SYN_SENT) {
> +			tcp_set_state(ssk, TCP_CLOSE);
> +			goto unlock;
> +		}
> +

The existing check for LISTEN and CLOSE states in this function uses

		if ((1 << ssk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)).

For consistency, it would be better to use the same style for the SYN_SENT
check here:

		if ((1 << ssk->sk_state) & TCPF_SYN_SENT)

This keeps the code style uniform throughout the function. WDYT?

Thanks,
-Geliang

>  		/* Initialize rcv_mss to TCP_MIN_MSS to avoid division by 0
>  		 * issue in __tcp_select_window(), see tcp_disconnect().
>  		 */
