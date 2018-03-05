Content-Type: multipart/mixed; boundary="===============6544037634256674220=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Next steps discussion
Date: Mon, 05 Mar 2018 11:25:00 +0100
Message-ID: <CAKuKrBn4mR=pf46atfj=SaT4bw+i-NGDw2nxavHpnm6DVR4zFQ@mail.gmail.com>
In-Reply-To: alpine.OSX.2.21.1803020721250.35336@avkulkar-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 343

--===============6544037634256674220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Christoph,

On Fri, Mar 2, 2018 at 4:37 PM, Mat Martineau <
mathew.j.martineau(a)linux.intel.com> wrote:

>                   Another issue may be the time. I think you are all in
>> the west coast of the
>>                   US :-)
>>                   But I am sure I can find time on the evening for a
>> short meeting!
>>
>>
>>             Ideally for me, it would be at 9am (for you 6pm). Otherwise,
>> I can make 8am
>>             as well (5pm for you).
>>
>>             I don't know what the opinion of the others is on the timing.
>>
>>
>>       I'm also in the Pacific time zone, as are my coworkers Peter and
>> Ossama. Personally, 9am works better.
>>
>>
>> 9am (6pm here) is good for me!
>>
>> When would you like to have our first meeting? At 6pm, I should not have
>> any other meetings.
>> Exceptionally I will not be available this Tuesday 6th of March. Just to
>> propose a date, what about Wednesday 7th of March?
>>
>
> Wednesday the 7th of March is the one morning next week I have a conflict
> at 9am, but I am available at 9:30. Other mornings at 9 are ok.


Just to be safe and not force you to rush finishing your meeting on time,
we can do that this Thursday at 9am? (8th of March, International Women's
Day)

I am going to send a calendar invitation to both of you. Can I add someone
else? Rao maybe?

      From earlier in this sub-thread:
>>
>>                  This is what I'm working on now. For outgoing packets, I
>> have a way
>>                  to optionally allocate sk_buffs with extra control block
>> space. For
>>                  incoming packets, my initial experiment is with
>> preventing packet
>>                  coalesce/collapse so TCP options are still in the skb
>> headroom. I
>>                  don't consider that a long-term solution, though. Some
>> kind of
>>                  lookup table will probably be needed.
>>
>>             That looks interesting!
>>
>>             On some systems with hardware acceleration to bypass the main
>> CPU for established connections, I guess they also
>>             have to modify the skb to share info between the main CPU and
>> another component. Do you have any ideas how they
>>             are doing that? It is maybe not a real problem for them to
>> increase the size of the skb if most of the traffic
>>             goes in the "fast path".
>>
>>
>>       Are you referring to userspace stacks (like DPDK), or optimizations
>> like GRO? I'm not sure of the specific answer to your
>>       question, but from what I see the drivers try to allocate enough
>> space in the skbs to accomodate the storage needs through
>>       the skb's lifetime.
>>
>>
>> Sorry, I was not clear. I don't know if it is common to do that, maybe
>> not because it is not upstream.
>>
>> In short, the NIC (or another external HW module) of a router/switch is
>> doing some learning about the flows it needs to forward. Once
>> this NIC/module knows the flow, the Linux network stack no longer see the
>> rest of a traffic because it has been "accelerated".
>> Here is a longer description when this is done by the NIC:
>> https://www.netronome.com/media/documents/WP_Hardware_Accele
>> ration.pdf#WP_Hardware_Acceleration.indd%3A.3203%3A27
>>
>> But I guess there are some info that the NIC/module cannot learn by
>> itself when looking at the beginning of the flow like what QoS to
>> apply, if a specific flow can be "accelerated" or not, etc. These info
>> are certainly shared in the skb.
>>
>> Now that I am thinking more about this scenario, it will maybe not help
>> for our MPTCP case. I was supposing these info shared via the skb
>> could be randomly present. But even if the skb is bigger all the time, I
>> guess this is not a problem for them because at the end, the
>> Linux network stack will only see a very small part of the traffic, not a
>> big deal to have more cache misses for the slow path only (and
>> some other exceptions).
>> In other words, their skb is maybe too big as well but that's not a
>> problem.
>>
>
> The only case where I'm allocating larger skbs is on the outgoing path
> where MPTCP code can control allocation, and it happens in a way that's
> transparent to most users of the skb. While it would be great to have the
> space on received skbs I wanted to leave control of incoming skb allocati=
on
> with the drivers.
>
> I'm using an updated version of this:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/martineau/
> linux.git/commit/?h=3Dsharedcb&id=3D8fffadb6b1ee0dc23e8eed43e40e15f5a6277=
307
>
> In short, the shinfo part of the skb has additional bytes allocated but
> code that expects a "normal" skb sees only the normal part of the skb. It=
's
> fine for the payload part of the skb to be any size, since the shinfo area
> is tracked separately.


Thank you for the explanations! That looks promising!
Do you think this approach could also be interesting for TCP TLS project?

Best regards,
Matthieu
-- =

[image: Tessares SA] <http://www.tessares.net> Matthieu Baerts | R&D
Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
<https://www.google.com/maps?q=3D1+Avenue+Jean+Monnet,+1348+Ottignies-Louva=
in-la-Neuve,+Belgium>

-- =


------------------------------
DISCLAIMER.
This email and any files transmitted with it are confidential and intended =

solely for the use of the individual or entity to whom they are addressed. =

If you have received this email in error please notify the system manager. =

This message contains confidential information and is intended only for the =

individual named. If you are not the named addressee you should not =

disseminate, distribute or copy this e-mail. Please notify the sender =

immediately by e-mail if you have received this e-mail by mistake and =

delete this e-mail from your system. If you are not the intended recipient =

you are notified that disclosing, copying, distributing or taking any =

action in reliance on the contents of this information is strictly =

prohibited.

--===============6544037634256674220==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgTWF0LCBDaHJpc3RvcGgsPGJyPjxkaXY+PGRpdiBjbGFzcz0iZ21h
aWxfZXh0cmEiPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gRnJpLCBNYXIgMiwgMjAx
OCBhdCA0OjM3IFBNLCBNYXQgTWFydGluZWF1IDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0i
bWFpbHRvOm1hdGhldy5qLm1hcnRpbmVhdUBsaW51eC5pbnRlbC5jb20iIHRhcmdldD0iX2JsYW5r
Ij5tYXRoZXcuai5tYXJ0aW5lYXVAbGludXguaW50ZWwuY29tPC9hPiZndDs8L3NwYW4+IHdyb3Rl
OjxzcGFuIGNsYXNzPSJnbWFpbC0iPjwvc3Bhbj48YnI+PHNwYW4gY2xhc3M9ImdtYWlsLSI+PC9z
cGFuPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4
IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5n
LWxlZnQ6MWV4Ij48c3BhbiBjbGFzcz0iZ21haWwtIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxf
cXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNv
bGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+CsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIEFub3RoZXIgaXNzdWUgbWF5IGJlIHRoZSB0aW1lLiBJIHRoaW5rIHlvdSBhcmUg
YWxsIGluIHRoZSB3ZXN0IGNvYXN0IG9mIHRoZTxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgVVMgOi0pPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBCdXQgSSBhbSBzdXJlIEkg
Y2FuIGZpbmQgdGltZSBvbiB0aGUgZXZlbmluZyBmb3IgYSBzaG9ydCBtZWV0aW5nITxicj4KPGJy
Pgo8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIElkZWFsbHkgZm9yIG1lLCBpdCB3b3VsZCBiZSBhdCA5
YW0gKGZvciB5b3UgNnBtKS4gT3RoZXJ3aXNlLCBJIGNhbiBtYWtlIDhhbTxicj4KwqAgwqAgwqAg
wqAgwqAgwqAgYXMgd2VsbCAoNXBtIGZvciB5b3UpLjxicj4KPGJyPgrCoCDCoCDCoCDCoCDCoCDC
oCBJIGRvbiYjMzk7dCBrbm93IHdoYXQgdGhlIG9waW5pb24gb2YgdGhlIG90aGVycyBpcyBvbiB0
aGUgdGltaW5nLjxicj4KPGJyPgo8YnI+CsKgIMKgIMKgIEkmIzM5O20gYWxzbyBpbiB0aGUgUGFj
aWZpYyB0aW1lIHpvbmUsIGFzIGFyZSBteSBjb3dvcmtlcnMgUGV0ZXIgYW5kIE9zc2FtYS4gUGVy
c29uYWxseSwgOWFtIHdvcmtzIGJldHRlci48YnI+Cjxicj4KPGJyPgo5YW0gKDZwbSBoZXJlKSBp
cyBnb29kIGZvciBtZSE8YnI+Cjxicj4KV2hlbiB3b3VsZCB5b3UgbGlrZSB0byBoYXZlIG91ciBm
aXJzdCBtZWV0aW5nPyBBdCA2cG0sIEkgc2hvdWxkIG5vdCBoYXZlIGFueSBvdGhlciBtZWV0aW5n
cy48YnI+CkV4Y2VwdGlvbmFsbHkgSSB3aWxsIG5vdCBiZSBhdmFpbGFibGUgdGhpcyBUdWVzZGF5
IDZ0aCBvZiBNYXJjaC4gSnVzdCB0byBwcm9wb3NlIGEgZGF0ZSwgd2hhdCBhYm91dCBXZWRuZXNk
YXkgN3RoIG9mIE1hcmNoPzxicj4KPC9ibG9ja3F1b3RlPgo8YnI+PC9zcGFuPgpXZWRuZXNkYXkg
dGhlIDd0aCBvZiBNYXJjaCBpcyB0aGUgb25lIG1vcm5pbmcgbmV4dCB3ZWVrIEkgaGF2ZSBhIGNv
bmZsaWN0IGF0IDlhbSwgYnV0IEkgYW0gYXZhaWxhYmxlIGF0IDk6MzAuIE90aGVyIG1vcm5pbmdz
IGF0IDkgYXJlIG9rLjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2Pkp1c3QgdG8gYmUg
c2FmZSBhbmQgbm90IGZvcmNlIHlvdSB0byBydXNoIGZpbmlzaGluZyB5b3VyIG1lZXRpbmcgb24g
dGltZSwgd2UgY2FuIGRvIHRoYXQgdGhpcyBUaHVyc2RheSBhdCA5YW0/ICg4dGggb2YgTWFyY2gs
IEludGVybmF0aW9uYWwgV29tZW4mIzM5O3MgRGF5KTxicj48YnI+PC9kaXY+PGRpdj5JIGFtIGdv
aW5nIHRvIHNlbmQgYSBjYWxlbmRhciBpbnZpdGF0aW9uIHRvIGJvdGggb2YgeW91LiBDYW4gSSBh
ZGQgc29tZW9uZSBlbHNlPyBSYW8gbWF5YmU/PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhl
eDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4
Ij48ZGl2PjxkaXYgY2xhc3M9ImdtYWlsLWg1Ij48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlk
IHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+CgrCoCDCoCDCoCBGcm9tIGVhcmxp
ZXIgaW4gdGhpcyBzdWItdGhyZWFkOjxicj4KPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oFRoaXMgaXMgd2hhdCBJJiMzOTttIHdvcmtpbmcgb24gbm93LiBGb3Igb3V0Z29pbmcgcGFja2V0
cywgSSBoYXZlIGEgd2F5PGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRvIG9wdGlvbmFs
bHkgYWxsb2NhdGUgc2tfYnVmZnMgd2l0aCBleHRyYSBjb250cm9sIGJsb2NrIHNwYWNlLiBGb3I8
YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaW5jb21pbmcgcGFja2V0cywgbXkgaW5pdGlh
bCBleHBlcmltZW50IGlzIHdpdGggcHJldmVudGluZyBwYWNrZXQ8YnI+CsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgY29hbGVzY2UvY29sbGFwc2Ugc28gVENQIG9wdGlvbnMgYXJlIHN0aWxsIGlu
IHRoZSBza2IgaGVhZHJvb20uIEk8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZG9uJiMz
OTt0IGNvbnNpZGVyIHRoYXQgYSBsb25nLXRlcm0gc29sdXRpb24sIHRob3VnaC4gU29tZSBraW5k
IG9mPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGxvb2t1cCB0YWJsZSB3aWxsIHByb2Jh
Ymx5IGJlIG5lZWRlZC48YnI+Cjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgVGhhdCBsb29rcyBpbnRl
cmVzdGluZyE8YnI+Cjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgT24gc29tZSBzeXN0ZW1zIHdpdGgg
aGFyZHdhcmUgYWNjZWxlcmF0aW9uIHRvIGJ5cGFzcyB0aGUgbWFpbiBDUFUgZm9yIGVzdGFibGlz
aGVkIGNvbm5lY3Rpb25zLCBJIGd1ZXNzIHRoZXkgYWxzbzxicj4KwqAgwqAgwqAgwqAgwqAgwqAg
aGF2ZSB0byBtb2RpZnkgdGhlIHNrYiB0byBzaGFyZSBpbmZvIGJldHdlZW4gdGhlIG1haW4gQ1BV
IGFuZCBhbm90aGVyIGNvbXBvbmVudC4gRG8geW91IGhhdmUgYW55IGlkZWFzIGhvdyB0aGV5PGJy
PgrCoCDCoCDCoCDCoCDCoCDCoCBhcmUgZG9pbmcgdGhhdD8gSXQgaXMgbWF5YmUgbm90IGEgcmVh
bCBwcm9ibGVtIGZvciB0aGVtIHRvIGluY3JlYXNlIHRoZSBzaXplIG9mIHRoZSBza2IgaWYgbW9z
dCBvZiB0aGUgdHJhZmZpYzxicj4KwqAgwqAgwqAgwqAgwqAgwqAgZ29lcyBpbiB0aGUgJnF1b3Q7
ZmFzdCBwYXRoJnF1b3Q7Ljxicj4KPGJyPgo8YnI+CsKgIMKgIMKgIEFyZSB5b3UgcmVmZXJyaW5n
IHRvIHVzZXJzcGFjZSBzdGFja3MgKGxpa2UgRFBESyksIG9yIG9wdGltaXphdGlvbnMgbGlrZSBH
Uk8/IEkmIzM5O20gbm90IHN1cmUgb2YgdGhlIHNwZWNpZmljIGFuc3dlciB0byB5b3VyPGJyPgrC
oCDCoCDCoCBxdWVzdGlvbiwgYnV0IGZyb20gd2hhdCBJIHNlZSB0aGUgZHJpdmVycyB0cnkgdG8g
YWxsb2NhdGUgZW5vdWdoIHNwYWNlIGluIHRoZSBza2JzIHRvIGFjY29tb2RhdGUgdGhlIHN0b3Jh
Z2UgbmVlZHMgdGhyb3VnaDxicj4KwqAgwqAgwqAgdGhlIHNrYiYjMzk7cyBsaWZldGltZS48YnI+
Cjxicj4KPGJyPgpTb3JyeSwgSSB3YXMgbm90IGNsZWFyLiBJIGRvbiYjMzk7dCBrbm93IGlmIGl0
IGlzIGNvbW1vbiB0byBkbyB0aGF0LCBtYXliZSBub3QgYmVjYXVzZSBpdCBpcyBub3QgdXBzdHJl
YW0uPGJyPgo8YnI+CkluIHNob3J0LCB0aGUgTklDIChvciBhbm90aGVyIGV4dGVybmFsIEhXIG1v
ZHVsZSkgb2YgYSByb3V0ZXIvc3dpdGNoIGlzIGRvaW5nIHNvbWUgbGVhcm5pbmcgYWJvdXQgdGhl
IGZsb3dzIGl0IG5lZWRzIHRvIGZvcndhcmQuIE9uY2U8YnI+CnRoaXMgTklDL21vZHVsZSBrbm93
cyB0aGUgZmxvdywgdGhlIExpbnV4IG5ldHdvcmsgc3RhY2sgbm8gbG9uZ2VyIHNlZSB0aGUgcmVz
dCBvZiBhIHRyYWZmaWMgYmVjYXVzZSBpdCBoYXMgYmVlbiAmcXVvdDthY2NlbGVyYXRlZCZxdW90
Oy48YnI+CkhlcmUgaXMgYSBsb25nZXIgZGVzY3JpcHRpb24gd2hlbiB0aGlzIGlzIGRvbmUgYnkg
dGhlIE5JQzo8YnI+CjxhIGhyZWY9Imh0dHBzOi8vd3d3Lm5ldHJvbm9tZS5jb20vbWVkaWEvZG9j
dW1lbnRzL1dQX0hhcmR3YXJlX0FjY2VsZXJhdGlvbi5wZGYjV1BfSGFyZHdhcmVfQWNjZWxlcmF0
aW9uLmluZGQlM0EuMzIwMyUzQTI3IiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5o
dHRwczovL3d3dy5uZXRyb25vbWUuY29tL21lZGk8d2JyPmEvZG9jdW1lbnRzL1dQX0hhcmR3YXJl
X0FjY2VsZTx3YnI+cmF0aW9uLnBkZiNXUF9IYXJkd2FyZV9BY2NlbGVyPHdicj5hdGlvbi5pbmRk
JTNBLjMyMDMlM0EyNzwvYT48YnI+Cjxicj4KQnV0IEkgZ3Vlc3MgdGhlcmUgYXJlIHNvbWUgaW5m
byB0aGF0IHRoZSBOSUMvbW9kdWxlIGNhbm5vdCBsZWFybiBieSBpdHNlbGYgd2hlbiBsb29raW5n
IGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGZsb3cgbGlrZSB3aGF0IFFvUyB0bzxicj4KYXBwbHks
IGlmIGEgc3BlY2lmaWMgZmxvdyBjYW4gYmUgJnF1b3Q7YWNjZWxlcmF0ZWQmcXVvdDsgb3Igbm90
LCBldGMuIFRoZXNlIGluZm8gYXJlIGNlcnRhaW5seSBzaGFyZWQgaW4gdGhlIHNrYi48YnI+Cjxi
cj4KTm93IHRoYXQgSSBhbSB0aGlua2luZyBtb3JlIGFib3V0IHRoaXMgc2NlbmFyaW8sIGl0IHdp
bGwgbWF5YmUgbm90IGhlbHAgZm9yIG91ciBNUFRDUCBjYXNlLiBJIHdhcyBzdXBwb3NpbmcgdGhl
c2UgaW5mbyBzaGFyZWQgdmlhIHRoZSBza2I8YnI+CmNvdWxkIGJlIHJhbmRvbWx5IHByZXNlbnQu
IEJ1dCBldmVuIGlmIHRoZSBza2IgaXMgYmlnZ2VyIGFsbCB0aGUgdGltZSwgSSBndWVzcyB0aGlz
IGlzIG5vdCBhIHByb2JsZW0gZm9yIHRoZW0gYmVjYXVzZSBhdCB0aGUgZW5kLCB0aGU8YnI+Ckxp
bnV4IG5ldHdvcmsgc3RhY2sgd2lsbCBvbmx5IHNlZSBhIHZlcnkgc21hbGwgcGFydCBvZiB0aGUg
dHJhZmZpYywgbm90IGEgYmlnIGRlYWwgdG8gaGF2ZSBtb3JlIGNhY2hlIG1pc3NlcyBmb3IgdGhl
IHNsb3cgcGF0aCBvbmx5IChhbmQ8YnI+CnNvbWUgb3RoZXIgZXhjZXB0aW9ucykuPGJyPgpJbiBv
dGhlciB3b3JkcywgdGhlaXIgc2tiIGlzIG1heWJlIHRvbyBiaWcgYXMgd2VsbCBidXQgdGhhdCYj
Mzk7cyBub3QgYSBwcm9ibGVtLjxicj4KPC9ibG9ja3F1b3RlPgo8YnI+PC9kaXY+PC9kaXY+ClRo
ZSBvbmx5IGNhc2Ugd2hlcmUgSSYjMzk7bSBhbGxvY2F0aW5nIGxhcmdlciBza2JzIGlzIG9uIHRo
ZSBvdXRnb2luZyBwYXRoIHdoZXJlIE1QVENQIGNvZGUgY2FuIGNvbnRyb2wgYWxsb2NhdGlvbiwg
YW5kIGl0IGhhcHBlbnMgaW4gYSB3YXkgdGhhdCYjMzk7cyB0cmFuc3BhcmVudCB0byBtb3N0IHVz
ZXJzIG9mIHRoZSBza2IuIFdoaWxlIGl0IHdvdWxkIGJlIGdyZWF0IHRvIGhhdmUgdGhlIHNwYWNl
IG9uIHJlY2VpdmVkIHNrYnMgSSB3YW50ZWQgdG8gbGVhdmUgY29udHJvbCBvZiBpbmNvbWluZyBz
a2IgYWxsb2NhdGlvbiB3aXRoIHRoZSBkcml2ZXJzLjxicj4KPGJyPgpJJiMzOTttIHVzaW5nIGFu
IHVwZGF0ZWQgdmVyc2lvbiBvZiB0aGlzOjxicj4KPGJyPgo8YSBocmVmPSJodHRwczovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9tYXJ0aW5lYXUvbGludXguZ2l0L2Nv
bW1pdC8/aD1zaGFyZWRjYiZhbXA7aWQ9OGZmZmFkYjZiMWVlMGRjMjNlOGVlZDQzZTQwZTE1ZjVh
NjI3NzMwNyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtPHdicj4vbGludXgva2VybmVsL2dpdC9tYXJ0aW5lYXUvPHdicj5saW51
eC5naXQvY29tbWl0Lz9oPXNoYXJlZGNiJmFtcDs8d2JyPmlkPThmZmZhZGI2YjFlZTBkYzIzZThl
ZWQ0M2U0MDx3YnI+ZTE1ZjVhNjI3NzMwNzwvYT48YnI+Cjxicj4KSW4gc2hvcnQsIHRoZSBzaGlu
Zm8gcGFydCBvZiB0aGUgc2tiIGhhcyBhZGRpdGlvbmFsIGJ5dGVzIGFsbG9jYXRlZCBidXQgY29k
ZSB0aGF0IGV4cGVjdHMgYSAmcXVvdDtub3JtYWwmcXVvdDsgc2tiIHNlZXMgb25seSB0aGUgbm9y
bWFsIHBhcnQgb2YgdGhlIHNrYi4gSXQmIzM5O3MgZmluZSBmb3IgdGhlIHBheWxvYWQgcGFydCBv
ZiB0aGUgc2tiIHRvIGJlIGFueSBzaXplLCBzaW5jZSB0aGUgc2hpbmZvIGFyZWEgaXMgdHJhY2tl
ZCBzZXBhcmF0ZWx5LjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYW5rIHlvdSBm
b3IgdGhlIGV4cGxhbmF0aW9ucyEgVGhhdCBsb29rcyBwcm9taXNpbmchPGJyPkRvIHlvdSB0aGlu
ayB0aGlzIGFwcHJvYWNoIGNvdWxkIGFsc28gYmUgaW50ZXJlc3RpbmcgZm9yIFRDUCBUTFMgcHJv
amVjdD88YnI+PGJyPjwvZGl2PjxkaXY+QmVzdCByZWdhcmRzLDxicj48L2Rpdj48ZGl2Pk1hdHRo
aWV1PGJyPjwvZGl2PjwvZGl2Pi0tIDxicj48ZGl2IGNsYXNzPSJnbWFpbF9zaWduYXR1cmUiPjxk
aXYgZGlyPSJsdHIiPjxkaXY+PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2IGRpcj0ibHRyIj48dGFi
bGUgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O1RpbWVzIE5ldyBSb21hbiZxdW90OztsZXR0ZXIt
c3BhY2luZzpub3JtYWw7dGV4dC1pbmRlbnQ6MHB4O3RleHQtdHJhbnNmb3JtOm5vbmU7d29yZC1z
cGFjaW5nOjBweCIgYm9yZGVyPSIwIiB3aWR0aD0iMTAwJSI+PHRib2R5Pjx0cj48dGQgcm93c3Bh
bj0iMyIgc3R5bGU9InBhZGRpbmctbGVmdDo1cHg7cGFkZGluZy1yaWdodDo1cHgiIHdpZHRoPSIx
MCIgdmFsaWduPSJ0b3AiIGFsaWduPSJsZWZ0Ij48YSBocmVmPSJodHRwOi8vd3d3LnRlc3NhcmVz
Lm5ldCIgdGFyZ2V0PSJfYmxhbmsiPjxpbWcgc3JjPSJodHRwOi8vd3d3LnRlc3NhcmVzLm5ldC9z
aWdsb2dvLnBuZyIgYWx0PSJUZXNzYXJlcyBTQSIgYm9yZGVyPSIwIiB3aWR0aD0iODAiIGhlaWdo
dD0iODAiPjwvYT48L3RkPjx0ZCBzdHlsZT0icGFkZGluZzowcHg7Zm9udC1mYW1pbHk6SGVsdmV0
aWNhLEFyaWFsLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEwcHgiIGhlaWdodD0iMTIiIGFsaWduPSJs
ZWZ0Ij48c3BhbiBzdHlsZT0iZm9udC13ZWlnaHQ6Ym9sZDtjb2xvcjpyZ2IoMzcsODMsMTU1KTtk
aXNwbGF5OmlubGluZSI+TWF0dGhpZXUgQmFlcnRzIHwgUiZhbXA7RCBFbmdpbmVlcjwvc3Bhbj48
L3RkPjwvdHI+PHRyPjx0ZCBzdHlsZT0icGFkZGluZzowcHg7Zm9udC1mYW1pbHk6SGVsdmV0aWNh
LEFyaWFsLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEwcHgiIGhlaWdodD0iMTIiIGFsaWduPSJsZWZ0
Ij48YSBocmVmPSJtYWlsdG86bWF0dGhpZXUuYmFlcnRzJTQwdGVzc2FyZXMubmV0IiBzdHlsZT0i
Y29sb3I6cmdiKDAsMCwwKTt0ZXh0LWRlY29yYXRpb246bm9uZTtkaXNwbGF5OmlubGluZSIgdGFy
Z2V0PSJfYmxhbmsiPm1hdHRoaWV1LmJhZXJ0c0B0ZXNzYXJlcy5uZXQ8YnI+PC9hPjwvdGQ+PC90
cj48dHI+PHRkIHN0eWxlPSJwYWRkaW5nOjBweDtmb250LWZhbWlseTpIZWx2ZXRpY2EsQXJpYWws
c2Fucy1zZXJpZjtmb250LXNpemU6MTBweCIgYWxpZ249ImxlZnQiPjxzcGFuIHN0eWxlPSJmb250
LXdlaWdodDpib2xkO2NvbG9yOnJnYigzNyw4MywxNTUpO2Rpc3BsYXk6aW5saW5lIj5UZXNzYXJl
cyBTQSB8IEh5YnJpZCBBY2Nlc3MgU29sdXRpb25zPGJyPjwvc3Bhbj48YSBocmVmPSJodHRwOi8v
d3d3LnRlc3NhcmVzLm5ldCIgc3R5bGU9ImNvbG9yOnJnYigwLDAsMCk7dGV4dC1kZWNvcmF0aW9u
Om5vbmU7ZGlzcGxheTppbmxpbmUiIHRhcmdldD0iX2JsYW5rIj53d3cudGVzc2FyZXMubmV0PC9h
PjxzcGFuPsKgPC9zcGFuPjxicj48YSBocmVmPSJodHRwczovL3d3dy5nb29nbGUuY29tL21hcHM/
cT0xK0F2ZW51ZStKZWFuK01vbm5ldCwrMTM0OCtPdHRpZ25pZXMtTG91dmFpbi1sYS1OZXV2ZSwr
QmVsZ2l1bSIgc3R5bGU9ImNvbG9yOnJnYigwLDAsMCk7dGV4dC1kZWNvcmF0aW9uOm5vbmU7ZGlz
cGxheTppbmxpbmUiIHRhcmdldD0iX2JsYW5rIj4xIEF2ZW51ZSBKZWFuIE1vbm5ldCwgMTM0OCBM
b3V2YWluLWxhLU5ldXZlLCBCZWxnaXVtPC9hPjwvdGQ+PC90cj48L3Rib2R5PjwvdGFibGU+PC9k
aXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+CjwvZGl2PjwvZGl2PjwvZGl2PgoKPGJy
Pgo8ZGl2Pjxicj48aHI+PC9kaXY+PGZvbnQgc2l6ZT0iMSI+PHNwYW4gc3R5bGU9ImZvbnQtZmFt
aWx5OlZlcmRhbmEsc2Fucy1zZXJpZjtiYWNrZ3JvdW5kLWNvbG9yOnJnYigyNTUsMjU1LDI1NSki
PkRJU0NMQUlNRVIuPC9zcGFuPjxiciBzdHlsZT0iZm9udC1mYW1pbHk6VmVyZGFuYSxzYW5zLXNl
cmlmO2JhY2tncm91bmQtY29sb3I6cmdiKDI1NSwyNTUsMjU1KSI+PGZvbnQgY29sb3I9IiMwMDAw
MDAiIGZhY2U9IlZlcmRhbmEsIHNhbnMtc2VyaWYiIHN0eWxlPSJiYWNrZ3JvdW5kLWNvbG9yOnJn
YigyNTUsMjU1LDI1NSkiPlRoaXMgZW1haWwgYW5kIGFueSBmaWxlcyB0cmFuc21pdHRlZCB3aXRo
IGl0IGFyZSBjb25maWRlbnRpYWwgYW5kIGludGVuZGVkIHNvbGVseSBmb3IgdGhlIHVzZSBvZiB0
aGUgaW5kaXZpZHVhbCBvciBlbnRpdHkgdG8gd2hvbSB0aGV5IGFyZSBhZGRyZXNzZWQuIElmIHlv
dSBoYXZlIHJlY2VpdmVkIHRoaXMgZW1haWwgaW4gZXJyb3IgcGxlYXNlIG5vdGlmeSB0aGUgc3lz
dGVtIG1hbmFnZXIuIFRoaXMgbWVzc2FnZSBjb250YWlucyBjb25maWRlbnRpYWwgaW5mb3JtYXRp
b24gYW5kIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBpbmRpdmlkdWFsIG5hbWVkLiBJZiB5b3Ug
YXJlIG5vdCB0aGUgbmFtZWQgYWRkcmVzc2VlIHlvdSBzaG91bGQgbm90IGRpc3NlbWluYXRlLCBk
aXN0cmlidXRlIG9yIGNvcHkgdGhpcyBlLW1haWwuIFBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBp
bW1lZGlhdGVseSBieSBlLW1haWwgaWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlLW1haWwgYnkg
bWlzdGFrZSBhbmQgZGVsZXRlIHRoaXMgZS1tYWlsIGZyb20geW91ciBzeXN0ZW0uIElmIHlvdSBh
cmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQgeW91IGFyZSBub3RpZmllZCB0aGF0IGRpc2Ns
b3NpbmcsIGNvcHlpbmcsIGRpc3RyaWJ1dGluZyBvciB0YWtpbmcgYW55IGFjdGlvbiBpbiByZWxp
YW5jZSBvbiB0aGUgY29udGVudHMgb2YgdGhpcyBpbmZvcm1hdGlvbiBpcyBzdHJpY3RseSBwcm9o
aWJpdGVkLjwvZm9udD48L2ZvbnQ+
--===============6544037634256674220==--
